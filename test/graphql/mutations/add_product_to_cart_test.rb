require 'test_helper'

class Mutations::AddProductToCartTest < ActiveSupport::TestCase
    def preform(args = {})
        Mutations::AddProductToCart.new.call(nil, args, {cookies: {}})
    end
    
    def signInUser(args = {})
        Mutations::SignInUser.new.call(nil, args, {cookies: {}})
    end

    setup do
        @user = User.create! name: 'test', email: 'testUserEmail@example.com', password: 'test'
        @user = signInUser(
            credentials: {
                email: @user.email,
                password: @user.password
            }
        )
    end

    # Test creating a standard valid Product
    test 'add exsiting product with a valid inventory count to cart' do
        @user = User.find_by(email: @user.email)
        Mutations::CreateCart.new.call(nil, {}, {current_user: @user})
        result = preform(
            product_id: products(:one).id,
            quantity: 1
        )

        assert_equal result.quantity, 1
        assert_equal result.cost, 1.75
        assert_equal carts(:one).total_price, 1.75
        assert_equal carts(:one).product_count, 1
    end

    test 'adding a non-exsitant product' do
        assert_raises(GraphQL::ExecutionError) do
            preform(
                product_id: 234,
                quantity: 1,
            )
        end
    end

    test 'adding a existing product with invalid quanityt' do
        assert_raises(GraphQL::ExecutionError) do
            preform(
                product_id: products(:one).id,
                quantity: 999999999
            )
        end
    end
end