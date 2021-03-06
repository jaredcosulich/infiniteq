require 'test_helper'

class TopicsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @topic = topics(:one)
  end

  test "should get index" do
    get topics_url
    assert_response :success
  end

  test "should get new" do
    user = users(:registered)
    sign_in user
    
    get new_topic_url
    assert_response :success
  end

  test "should create topic" do
    user = users(:registered)
    sign_in user

    assert_difference('user.topics.count') do
      post topics_url, params: { topic: { description: @topic.description, title: @topic.title } }
    end

    assert topic = Topic.unscoped.last
    assert_equal user, topic.user
    assert_equal user, topic.followings.first.user

    assert_redirected_to topic_url(Topic.last)
  end

  test "#create should assign parent topic if set" do
    user = users(:registered)
    sign_in user

    post topics_url, params: { topic: { title: 'Title', parent_topic_id: @topic.id } }

    assert_equal @topic, Topic.last.parent_topic
  end

  test "should show topic" do
    get topic_url(@topic)
    assert_response :success
  end

  test "should get edit" do
    user = users(:registered)
    sign_in user
    get edit_topic_url(@topic)
    assert_response :success
  end

  test "should update topic" do
    user = users(:registered)
    sign_in user
    patch topic_url(@topic), params: { topic: { description: @topic.description, title: @topic.title } }
    assert_redirected_to topic_url(@topic)
  end

  test "should destroy topic" do
    user = users(:registered)
    sign_in user
    assert_difference('Topic.count', -1) do
      delete topic_url(@topic)
    end

    assert_redirected_to topics_url
  end

  test "#show displays subtopics" do
    get topic_url(@topic)
    assert_select 'a', 'Child Topic (0)'
  end
end
