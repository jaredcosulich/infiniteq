require 'test_helper'

class QuestionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @question = questions(:one)
  end

  test "should show question" do
    get question_url(@question)
    assert_response :success
  end

  test "should get edit" do
    get edit_question_url(@question)
    assert_response :success
  end

  test "should create question" do
    user = users(:registered)
    follower_users = [users(:another_registered), users(:unconfirmed)]
    topic = @question.topic
    follower_users.each do |follower_user|
      topic.followings.create(user: follower_user)
    end

    sign_in user

    assert_difference('topic.questions.count') do
      post questions_url, params: { question: { topic_id: topic.id, text: @question.text } }
    end

    assert question = topic.reload.questions.unscoped.last
    assert_equal @question.text, question.text

    follower_users.each do |follower_user|
      assert follower_email = ActionMailer::Base.deliveries.select { |e| e.to == [follower_user.email] }.last
      assert_equal "InfiniteQ: Question added to topic: #{topic.title}", follower_email.subject
      assert_equal ['support@infiniteq.net'], follower_email.from
      assert follower_email.encoded.include? question.text
      assert follower_email.encoded.include? 'unsubscribe'
    end

    assert_redirected_to question
  end

  test "should update question" do
    patch question_url(@question), params: { question: { details: @question.details, text: @question.text, topic_id: @question.topic_id, user_id: @question.user_id } }
    assert_redirected_to @question
  end

  test "should destroy question" do
    assert_difference('Question.count', -1) do
      delete question_url(@question)
    end

    assert_redirected_to topics(:one)
  end

end
