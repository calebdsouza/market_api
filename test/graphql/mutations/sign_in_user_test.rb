require 'test_helper'

class Mutations::SignInUserTest < ActiveSupport::TestCase
    def preform(args = {})
        Mutations::SignInUser.nwe.call(nil, args, {cookies: {}})
    end

    setup do
        @user = User.create! name: 'test', email: 'testUserEmail@example.com', password: 'test'
    end
    
    test 'create a token' do
        result = preform(
            email: {
                email: @user.email,
                password: @user.password
            }
        )
        assert result.present?
        assert result.token.present?
        assert_equal result.user, @user
    end
    
    test 'handling no credentials' do
    assert_nil perform
    end

    test 'handling wrong email' do
    assert_nil perform(email: { email: 'wrong' })
    end

    test 'handling wrong password' do
    assert_nil perform(email: { email: @user.email, password: 'wrong' })
    end
end
