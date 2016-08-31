require 'test_helper'
require 'capybara/rails'
require 'capybara/poltergeist'

Capybara.javascript_driver = :poltergeist

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end

  def sign_in(user)
    visit  '/users/sign_in'

    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: 'password'

    click_button 'Log In'

    assert page.has_content?('Signed in successfully.')
  end

  def sign_out
    click_button 'Log Out'
    assert page.has_content?('Signed out successfully.')
  end

end
