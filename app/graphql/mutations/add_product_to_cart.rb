# Mutatoin resolver to add a Product of a certian quantity to a User's Cart
class Mutations::AddProductToCart < GraphQL::Function
    # Arguments passed as 'args' needed to add a product of valid quantity to a cart
    argument :product_id, !types.ID
    argument :quantity, !types.Int

    # Define return type from the mutation of CartProduct node
    type Types::CartsProductsType

    # The mutation method for adding a product to current user's cart
    # _obj - parent object, which in this case is nil
    # args - arguments passed (product_id, quantity)
    # ctx - Session context
    def call(_obj, args, ctx)
        # Check if product id is valid
        product = Product.find_by(id: args[:product_id])
        unless product
            raise GraphQL::ExecutionError.new("Product not found")
        end 

        # Check if the product quantity wanted is valid
        unless (args[:quantity] <= product[:inventory_count])
            raise GraphQL::ExecutionError.new(
                "Given quantity exceeds avalibale quantity of #{
                    product[:inventory_count]
                }")
        end 

        # Get the current User's Cart
        cart = Cart.find_by(user: ctx[:current_user])
        unless cart
            raise GraphQL::ExecutionError.new("User's Cart not found")
        end

        # Check if Product to be added is already in User's Cart
        cartProduct = CartsProducts.find_by(cart: cart, product: product)

        # Calculate cost of products
        cost = args[:quantity] * product[:price]
        
        # Update current User's Cart infomation
        new_count = args[:quantity] + cart[:product_count]
        new_price = cost + cart[:total_price]
        cart.update(
            total_price: new_price,
            product_count: new_count
        )

        # Check if prdocut exsit in the User's Cart
        if cartProduct
            # Update new quanities of existing Product in Cart
            cartProduct.update(
                quantity: cartProduct[:quantity] + args[:quantity],
                cost: cartProduct[:cost] + cost
            )
            return cartProduct
        else
            # Add Product to Cart
            CartsProducts.create!(
                cart: cart,
                product: product,
                quantity: args[:quantity],
                cost: cost
            )
        end

    # Catch all validation errors
    rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new("Invalid input: #{
            e.record.errors.full_messages.join(', ')
            }")
    end
end        
