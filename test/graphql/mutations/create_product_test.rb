require 'test_helper'

class Mutations::CreateProductTest < ActiveSupport::TestCase
    def preform(args = {})
        Mutations::CreateProduct.new.call(nil, args, {})
    end

    test 'creating new product' do
        link = preform(
            title: 'Chocolate Bar',
            price: 3.25,
            inventory_count: 50,
        )

        assert product.persisted?
        assert_equal product.title, 'Chocolate Bar'
        assert_equal product.price, 3.23
        assert_equal product.inventory_count, 50
    end
end
