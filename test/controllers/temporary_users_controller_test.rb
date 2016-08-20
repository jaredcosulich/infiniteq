require 'test_helper'

class TemporaryUsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @temporary_user = temporary_users(:one)
  end

  test "should get index" do
    get temporary_users_url
    assert_response :success
  end

  test "should get new" do
    get new_temporary_user_url
    assert_response :success
  end

  test "should create temporary_user" do
    assert_difference('TemporaryUser.count') do
      post temporary_users_url, params: { temporary_user: { answers: @temporary_user.answers, ip_address: @temporary_user.ip_address, questions: @temporary_user.questions, votes: @temporary_user.votes } }
    end

    assert_redirected_to temporary_user_url(TemporaryUser.last)
  end

  test "should show temporary_user" do
    get temporary_user_url(@temporary_user)
    assert_response :success
  end

  test "should get edit" do
    get edit_temporary_user_url(@temporary_user)
    assert_response :success
  end

  test "should update temporary_user" do
    patch temporary_user_url(@temporary_user), params: { temporary_user: { answers: @temporary_user.answers, ip_address: @temporary_user.ip_address, questions: @temporary_user.questions, votes: @temporary_user.votes } }
    assert_redirected_to temporary_user_url(@temporary_user)
  end

  test "should destroy temporary_user" do
    assert_difference('TemporaryUser.count', -1) do
      delete temporary_user_url(@temporary_user)
    end

    assert_redirected_to temporary_users_url
  end
end
