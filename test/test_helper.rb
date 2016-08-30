ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  def sign_in(user)
    get  '/users/sign_in'
    assert_response :success

    post '/users/sign_in', params: {
      "user[email]"    => user.email,
      "user[password]" => 'password'
    }
    follow_redirect!

    assert_response :success
    assert_select '.notice', 'Signed in successfully.'
  end

  def sign_out
    delete '/users/sign_out'
    follow_redirect!

    assert_response :success
    assert_select '.notice', 'Signed out successfully.'
  end
end
