# Mutation resolver to sign in a User
class Mutations::SignInUser < GraphQL::Function
    # Arguments passed as 'args' needed to sign in a User
    argument :credentials, !Types::AuthProviderCredInput

    # Define return type for the mutation of Sign In User
    type do
        name 'SigninPayload'

        field :token, types.String
        field :user, Types::UserType
    end

    # The mutation method for signing in a User
    # _obj - parent object, which in this case is nil
    # args - arguments passed (email)
    # ctx - GraphQL API User context
    def call(_obj, args, ctx)
        # Current unauthenticed user's email
        credentials = args[:credentials]

        # Check if given email is valid
        return unless credentials

        # If given email is valid then find User with related email
        user = User.find_by email: credentials[:email]
        # Confirm the User found is correct
        return unless user
        return unless user.authenticate(credentials[:password])

        # Get JWT and added to session
        token = AuthToken.issue(user)
        ctx[:session] = {token: token}

        # Package jwt
        OpenStruct.new({
            user: user,
            token: token
        })
    end
end
