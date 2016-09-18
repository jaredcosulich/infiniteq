require 'test_helper'

class AnswersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @answer = answers(:one)
  end

  test "should get new" do
    get new_answer_url
    assert_response :success
  end

  test "should create answer" do
    user = users(:registered)
    follower_users = [users(:another_registered), users(:unconfirmed)]
    question = @answer.question
    follower_users.each do |follower_user|
      question.followings.create(user: follower_user)
    end

    sign_in user

    assert_difference('Answer.count') do
      post answers_url, params: { answer: { question_id: @answer.question_id, text: @answer.text } }
    end

    Delayed::Worker.new.work_off

    follower_users.each do |follower_user|
      assert follower_email = ActionMailer::Base.deliveries.select { |e| e.to == [follower_user.email] }.last
      assert_equal "InfiniteQ: Answer added to question: #{question.text}", follower_email.subject
      assert_equal ['support@infiniteq.net'], follower_email.from
      assert follower_email.encoded.include? @answer.text
      assert follower_email.encoded.include? 'unsubscribe'
    end

    assert_redirected_to question
  end

  test "should show answer" do
    get answer_url(@answer)
    assert_response :success
  end

  test "should get edit" do
    get edit_answer_url(@answer)
    assert_response :success
  end

  test "should update answer" do
    patch answer_url(@answer), params: { answer: { question_id: @answer.question_id, text: @answer.text, user_id: @answer.user_id } }
    assert_redirected_to questions(:one)
  end

  test "should destroy answer" do
    assert_difference('Answer.count', -1) do
      delete answer_url(@answer)
    end

    assert_redirected_to questions(:one)
  end
end
