# Define new GraphQL type, Cart
Types::CartType = GraphQL::ObjectType.define do
    # Set this type's name to 'Cart'
    name 'Cart'

    # Define the following fields for the Cart GraphQL type
    field :id, !types.ID
    field :user, -> {Types::UserType}
    field :total_price, !types.Float 
    field :product_count, !types.Int 

end