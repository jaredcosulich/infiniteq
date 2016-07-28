require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_path
    assert_response :success
  end

  test 'get INDEX should only display parent topics' do
    get root_path
    assert_select 'a', 'MyString', true
    assert_select 'a', 'MyString2', true
    assert_select "a", {count: 0, text: "Child Topic"}
  end

end
