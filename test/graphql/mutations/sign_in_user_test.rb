require 'test_helper'

class Mutations::SignInUserTest < ActiveSupport::TestCase
    def perform(args = {})
        Mutations::SignInUser.new.call(nil, args, {cookies: {}})
    end

    setup do
        @user = User.create! name: 'test', email: 'testUserEmail@example.com', password: 'test'
    end
    
    test 'create a token' do
        result = perform(
            credentials: {
                email: @user.email,
                password: @user.password
            }
        )
        assert result.present?
        assert result.token.present?
        assert_equal result.user, @user
    end
    
    test 'handling no credentials' do
        assert_raises(GraphQL::ExecutionError) do
            perform()
        end
    end

    test 'handling wrong email' do
        assert_raises(ActiveRecord::RecordNotFound) do
            perform(credentials: { email: 'wrong' })
        end
    end

    test 'handling wrong password' do
        assert_raises() do
            perform(credentials: { email: @user.email, password: 'wrong' })
        end
    end
end
