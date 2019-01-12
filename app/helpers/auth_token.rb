class AuthToken

    # Generate sercet method
    def self.getSecret
        Rails.application.secrets.secret_key_base
    end

    # Generate JWT token method using default HS256 hash
    # user - the user to generate the token for
    def self.issue(user)
        payload = {user_id: user.id}
        JsonWebToken.sign(payload, key: getSecret)
    end

    # Verification of given JWT using dedault HS256 hash
    # token - the token to be decoded and verified
    def self.verify(token)
        result = JsonWebToken.verify(token, key: getSecret)
        return nil if result[:error]
        user.find_by(id: result[:ok][:user_id])
    end
end