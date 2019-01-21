# Mutation resolver to create a new Cart
class Mutations::CreateCart < GraphQL::Function
    INIT_TOTAL_PRICE = 0.00
    INIT_PROD_COUNT = 0
    # Arguments pass as 'args' needed to create a new Cart
    # argument :user, Types::CartType

    # Define the return type from the mutation of creating a new Cart
    type Types::CartType

    # The mutation method for creating a new cart
    # _obj - parent object, which in this case is nil
    # args - arguments passed (user)
    # ctx - Session context
    def call(_obj, args, ctx)
        cart = Cart.find_by user: ctx[:current_user]
        # Check if the user already has a cart
        unless !cart
            raise GraphQL::ExecutionError.new(
                "This User alredy has a Cart: #{cart[:id]}")
        end 
        # Create a new empty Cart
        Cart.create!(
            user: ctx[:current_user],
            total_price: INIT_TOTAL_PRICE,
            product_count: INIT_PROD_COUNT
        )

        # Catch all validation errors
    rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new("Invalid input: #{
            e.record.errors.full_messages.join(', ')
            }")
    end
end
