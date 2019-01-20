# Mutation resolver to delete a Product from a User's Cart
class Mutations::DeleteProductFromCart < GraphQL::Function
    # Arguments passed as 'args' need to delete a Product from a User's Cart
    argument :product_id, !types.Int
    argument :quantity, types.Int

    # Define return type from the mutation of Cart being modified
    type Types::CartType

    # The mutation method for deleting a Product from the current User's Cart
    # _obj - parent object, which in case is nil
    # args - arguments passed (product_id) 
    # ctx - Session context to identify the curernt User
    def call(_obj, args, ctx)

        # Check if given Product ID is valid
        product = Product.find_by(id: args[:product_id])
        unless product
            return GraphQL::ExecutionError.new('Product not found')
        end

        # Get the current User's Cart and check if one exists
        cart = Cart.find_by(user: ctx[:current_user])
        unless cart
            return GraphQL::ExecutionError.new(
                "User's Cart not found. Check if User Created a Cart")
        end
       
        # Check if Product is in the User's Cart
        cartProduct = CartsProducts.find_by(cart: cart, product: product)
        unless cartProduct
            return GraphQL::ExecutionError.new("Product is not in this User's Cart")
        end

        # Check if the user what's to do a full delete or partial delete
        if args[:quantity]
            # Check if the given quantity is valid
            unless (args[:quantity] <= cartProduct[:quantity])
                return GraphQL::ExecutionError.new(
                    "Given quantity exceeds avalibale quantity of #{cartProduct[:quantity]}")
            end

            cost_deduction = product[:price] * args[:quantity]
            # Update the quanitiy of given Product in the current User's Cart
            cartProduct.update(
                quantity: cartProduct[:quantity] - args[:quantity],
                cost: cartProduct[:cost] - cost_deduction
            )
s
            # Update current User's Cart info
            cart.update(
                total_price: cart[:total_price] - cost_deduction,
                product_count: cart[:product_count] - args[:quantity]
            )
            if cartProduct[:quantity] == 0
                cartProduct.destroy
            end
        else
            # Update current User's Cart info
            new_price  = cart[:cost]
            cart.update(
                total_price: cart[:total_price] - cartProduct[:cost],
                product_count: cart[:product_count] - cartProduct[:quantity]
            )
            cartProduct.destroy
        end

        return cart
    end
end
