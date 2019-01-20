# Defines new GraphQL type, Product
Types::ProductType = GraphQL::ObjectType.define do
    # Set this type's name to 'Product'
    name 'Product'

    # Define the following feilds for the Product GraphQL type
    field :id, !types.ID
    field :title, !types.String
    field :price, !types.Float
    field :inventory_count, !types.Int
    field :carts, -> {!types[Types::CartType]}
end
