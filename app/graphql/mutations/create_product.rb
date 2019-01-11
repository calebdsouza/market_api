# Mutation resolver to create a new Product
class Mutations::CreateProduct < GraphQL::Function
    # Arguments passed as 'args' needed to create a new product
    argument :title, !types.String
    argument :price, !types.Float
    argument :inventory_count, !types.Int
    
    # Return type from the mutation of Product
    type Types::ProductType

    # the mutataion method for creating a new Product
    # _obj - parent object, which in this case is nil
    # args - arguments passed (title, price, inventory_count)
    # _ctx - GraphQL context
    def call(_obj, args, _ctx)
        Product.create!(
            title: args[:title],
            price: args[:price],
            inventory_count: args[:inventory_count],
        )
    end
end
