# Define a new GraphQL type, UserType
Types::UserType = GraphQL::ObjectType.define do
    # Set this GraphQL type's name to 'User'
    name 'User'

    # Define the fields for the User GraphQL type
    field :id, !types.ID
    field :name, !types.String
    field :email, !types.String
end