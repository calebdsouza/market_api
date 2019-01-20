# Define new GraphQL type, CartProduct to represent Products in a Cart
Types::CartsProductsType = GraphQL::ObjectType.define do
    # Set this type's name to 'CartProduct'
    name 'CartsProducts'

    # Define the following fields for the CartProduct GraphQL type
    field :id, !types.ID
    field :cart, -> {Types::CartType}
    field :product, -> {Types::ProductType}
    field :quantity, !types.Int
    field :cost, !types.Float
end