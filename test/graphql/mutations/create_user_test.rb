require 'test_helper'

class Mutations::CreateUserTest < ActiveSupport::TestCase
    def preform(args = {})
        Mutations::CreateUser.new.call(nil, args, nil)
    end

    # Test creating a standard vaild User
    test 'creating new user' do
        user = preform(
            name: 'Test User',
            authProvider: {
                email: {
                    email: 'myTestEmail@example.com',
                    password: '[omitted]'
                }
            }
        )

        assert user.persisted?
        assert_equal user.name, 'Test User'
        assert_equal user.email, 'myTestEmail@example.com'
    end
end
