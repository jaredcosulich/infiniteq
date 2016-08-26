require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:registered)
    @comment = comments(:one)
  end

  test "should create comment" do
    assert_difference('Comment.count') do
      post comments_url, params: { comment: { answer_id: @comment.answer_id, text: @comment.text, user_id: @comment.user_id } }
    end

    assert_redirected_to answers(:one)
  end

  test "should get edit" do
    get edit_comment_url(@comment)
    assert_response :success
  end

  test "should update comment" do
    patch comment_url(@comment), params: { comment: { answer_id: @comment.answer_id, parent_comment_id: @comment.parent_comment_id, question_id: @comment.question_id, text: @comment.text, user_id: @comment.user_id } }
    assert_redirected_to comment_url(@comment)
  end

  test "should destroy comment" do
    assert_difference('Comment.count', -1) do
      delete comment_url(@comment)
    end

    assert_redirected_to comments_url
  end
end
