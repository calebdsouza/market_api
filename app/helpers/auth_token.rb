class AuthToken

    # Generate sercet method
    def self.key
        Rails.application.credentials.secret_key_base.byteslice(0..31)
    end

    # Generate JWT token method using default HS256 hash
    # user - the user to generate the token for
    def self.issue(user)
        payload = {user_id: user.id}
        JsonWebToken.sign(payload, key: key)
    end

    # Verification of given JWT using dedault HS256 hash
    # token - the token to be decoded and verified
    def self.verify(token)
        result = JsonWebToken.verify(token, key: key)
        return nil if result[:error]
        user.find_by(id: result[:ok][:user_id])
    end
end