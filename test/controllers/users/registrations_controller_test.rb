require 'test_helper'

class Users::RegistrationsControllerTest < ActionDispatch::IntegrationTest

  setup do
  end

  test "should create a user" do
    assert_difference('User.count') do
      post '/users', params: {
        user: {
          name: 'Test User',
          email: 'test@example.com',
          password: 'testtest',
          password_confirmation: 'testtest'
        }
      }
    end

    assert user = User.last
    assert_equal 'Test User', user.name
    assert_equal 'test@example.com', user.email

    assert confirmation_email = ActionMailer::Base.deliveries.last
    assert_equal 'Confirmation instructions', confirmation_email.subject
    assert_equal ['support@infiniteq.net'], confirmation_email.from
    assert_equal ['test@example.com'], confirmation_email.to
    assert confirmation_email.encoded.include? 'test@example.com'
  end

end
