# Mutation resolver to confirm/checkout a User's Cart
class Mutations::ConfirmCart < GraphQL::Function
    # Arguments passed as 'args' needed to create a new product
    argument :password, !types.String

    # Define return type for the mutation of checking out a User's Cart
    type do
        name "CheckoutReceipt"

        field :status, !types.String
        field :cart, !Types::CartType
        field :total_price, !types.Float
    end

    # The mutation methof for checking-out a User's Cart
    # _obj - parent object, which in this case is nil
    # args - arguments passed (password)
    # ctx - GraphQL API User context
    def call(_obj, args, ctx)
        # Get the current User store in the current session
        user = User.find_by email: ctx[:current_user][:email]
        # Confirm the User found is valid
        unless user
            raise GraphQL::ExecutionError.new("No User found")
        end 
            
        # Confirm the given password is valid
        unless user.authenticate(args[:password])
            raise GraphQL::ExecutionError.new("Invalid credentials")
        end 

        # Get the current User's Cart info
        cart = Cart.find_by(user: ctx[:current_user])
        # Check if the Cart exists
        unless cart
            raise GraphQL::ExecutionError.new("User's Cart not found")
        end 

        total_price = cart[:total_price]

        # Find all the product this current user's Cart and delete them
        CartsProducts.where(cart: cart).find_each do |cartsProducts|
            cartProduct = CartsProducts.find_by(id: cartsProducts[:id])
            product = Product.find_by(id: cartProduct[:product_id])
            newCount = product[:inventory_count] - cartProduct[:quantity]
            product.update(
                inventory_count: newCount
            )
            cartProduct.destroy
        end
        # Then delete the Cart itself
        cart.destroy

        # Determine return status
        status = ((!Cart.find_by(user: ctx[:current_user]) &&
        !CartsProducts.find_by(cart: cart)) ? "Success" : "Failed")

        # Return receipt
        OpenStruct.new({
            status: status,
            cart: cart,
            total_price: total_price
        })
    end
end
