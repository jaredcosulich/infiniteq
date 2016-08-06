require 'test_helper'

class AnswerVotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @answer_vote = answer_votes(:one)
  end

  test "should get index" do
    get answer_votes_url
    assert_response :success
  end

  test "should get new" do
    get new_answer_vote_url
    assert_response :success
  end

  test "should create answer_vote" do
    assert_difference('AnswerVote.count') do
      post answer_votes_url, params: { answer_vote: { answer_id: @answer_vote.answer_id, trust: @answer_vote.trust, user_id: @answer_vote.user_id } }
    end

    assert_redirected_to answer_vote_url(AnswerVote.last)
  end

  test "should show answer_vote" do
    get answer_vote_url(@answer_vote)
    assert_response :success
  end

  test "should get edit" do
    get edit_answer_vote_url(@answer_vote)
    assert_response :success
  end

  test "should update answer_vote" do
    patch answer_vote_url(@answer_vote), params: { answer_vote: { answer_id: @answer_vote.answer_id, trust: @answer_vote.trust, user_id: @answer_vote.user_id } }
    assert_redirected_to answer_vote_url(@answer_vote)
  end

  test "should destroy answer_vote" do
    assert_difference('AnswerVote.count', -1) do
      delete answer_vote_url(@answer_vote)
    end

    assert_redirected_to answer_votes_url
  end
end
