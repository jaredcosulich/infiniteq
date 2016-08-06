require 'test_helper'

class QuestionVotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @question_vote = question_votes(:one)
  end

  test "should get index" do
    get question_votes_url
    assert_response :success
  end

  test "should get new" do
    get new_question_vote_url
    assert_response :success
  end

  test "should create question_vote" do
    assert_difference('QuestionVote.count') do
      post question_votes_url, params: { question_vote: { question_id: @question_vote.question_id, trust: @question_vote.trust, user_id: @question_vote.user_id } }
    end

    assert_redirected_to question_vote_url(QuestionVote.last)
  end

  test "should show question_vote" do
    get question_vote_url(@question_vote)
    assert_response :success
  end

  test "should get edit" do
    get edit_question_vote_url(@question_vote)
    assert_response :success
  end

  test "should update question_vote" do
    patch question_vote_url(@question_vote), params: { question_vote: { question_id: @question_vote.question_id, trust: @question_vote.trust, user_id: @question_vote.user_id } }
    assert_redirected_to question_vote_url(@question_vote)
  end

  test "should destroy question_vote" do
    assert_difference('QuestionVote.count', -1) do
      delete question_vote_url(@question_vote)
    end

    assert_redirected_to question_votes_url
  end
end
