# Define new GraphQL input type, 'AUTH_PROVIDER_EMAIL'
# for the authentication provider 
Types::AuthProviderCredInput = GraphQL::InputObjectType.define do
    name 'AUTH_PROVIDER_CRED'

    # Required arguments passed as 'args' needed to authenticate
    argument :email, !types.String
    argument :password, !types.String
end