require 'test_helper'

class FollowingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @following = followings(:one)
  end

  test "should create following" do
    assert_difference('Following.count') do
      post followings_url, params: { following: { topic_id: @following.topic_id, user_id: @following.user_id } }
    end

    assert_redirected_to @following.topic
  end

  test "should create following and assign user is signed in" do
    user = users(:registered)
    sign_in user

    assert_difference('Following.count user.followings.count') do
      post followings_url, params: { following: { topic_id: @following.topic_id, user_id: @following.user_id } }
    end

    assert_redirected_to @following.topic
    follow_redirect!
    assert_select 'a', 'Unfollow This Topic'
  end

  test "should destroy following" do
    assert_difference('Following.count', -1) do
      delete following_url(@following)
    end

    assert_redirected_to topics(:one)
  end
end
