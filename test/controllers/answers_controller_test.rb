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
    sign_in users(:registered)

    assert_difference('Answer.count') do
      post answers_url, params: { answer: { question_id: @answer.question_id, text: @answer.text, user_id: @answer.user_id } }
    end

    assert_redirected_to questions(:one)
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

    assert_redirected_to answers_url
  end
end
