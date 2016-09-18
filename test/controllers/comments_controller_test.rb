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

    assert_redirected_to questions(:one)
  end

  test "should create question comment" do
    user = users(:registered)
    follower_users = [users(:another_registered), users(:unconfirmed)]
    question = questions(:one)
    follower_users.each do |follower_user|
      question.followings.create(user: follower_user)
    end

    assert_difference('Comment.count') do
      post comments_url, params: { comment: { question_id: question.id, text: 'A New Comment', user_id: user.id } }
    end

    Delayed::Worker.new.work_off

    follower_users.each do |follower_user|
      assert follower_email = ActionMailer::Base.deliveries.select { |e| e.to == [follower_user.email] }.last
      assert_equal "InfiniteQ: Comment added to question: #{question.text}", follower_email.subject
      assert_equal ['support@infiniteq.net'], follower_email.from
      assert follower_email.encoded.include? 'A New Comment'
      assert follower_email.encoded.include? 'unsubscribe'
    end

    assert_redirected_to questions(:one)
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

    assert_redirected_to questions(:one)
  end
end
