# Defines new GraphQL type named Product
Types::ProductType = GraphQL::ObjectType.define do
    # Set this type's name to 'Product'
    name 'Product'

    # Define the following feilds for the product GraphQL type, Product
    field :id, !types.ID
    field :title, !types.String
    field :price, !types.Float
    field :inventory_count, !types.Int
end

