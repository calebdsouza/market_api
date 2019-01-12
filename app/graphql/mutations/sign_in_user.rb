# Mutation resolver to sign in a User
class Mutations::SignInUser < GraphQL::Function
    # Arguments passed as 'args' needed to sign in a User
    argument :email, !Types::AuthProviderEmailInput

    # Define return type for the mutation of Sign In User
    type do
        name 'SigninPayload'

        field :token, types.String
        field :user, Types::UserType
    end

    # The mutation method for signing in a User
    # _obj - parent object, which in this case is nil
    # args - arguments passed (email)
    # _ctx - GraphQL API User context
    def call(_obj, args, _ctx)
        # Current unauthenticed user's email
        input_email = args[:email]

        # Check if given email is validate
        return unless input_email

        # If given email is valid then find User with related email
        user = User.find_by email: input_email[:email]
        # Confirm the User found is correct
        return unless user
        return unless user.authenticate(input_email[:password])

        # Package jwt
        OpenStruct.new({
            user: user,
            token: AuthToken.issue(user)
        })
    end
end
