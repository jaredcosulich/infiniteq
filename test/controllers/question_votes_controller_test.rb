require 'test_helper'

class QuestionVotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @question_vote = question_votes(:one)
  end

  test "should create question_vote with positive value" do
    assert_difference('questions(:two).question_votes.count') do
      post question_question_votes_url(questions(:two)), params: { question_vote: { positive: 'true' } }
    end

    question_vote = questions(:two).question_votes.last
    assert_equal 1, question_vote.trust

    assert_select '.vote-total .small', '0.1'
  end

  test "should create question_vote with negative value" do
    assert_difference('questions(:two).question_votes.count') do
      post question_question_votes_url(questions(:two)), params: { question_vote: { positive: 'false' } }
    end

    question_vote = questions(:two).question_votes.last
    assert_equal -1, question_vote.trust

    assert_select '.vote-total .small', '-0.1'
  end

  # test "should not create new question_vote if one already exists" do
  #   assert_no_difference('QuestionVote.count') do
  #     post question_question_votes_url(questions(:two)), params: { question_vote: { positive: 'true' } }
  #   end
  #
  #   assert_redirected_to question_vote_url(QuestionVote.last)
  # end

  test "should destroy question_vote" do
    assert_difference('questions(:one).question_votes.count', -1) do
      delete question_question_vote_url(questions(:one), @question_vote)
    end

    assert_select '.vote-total .small', '-0.1'
  end
end
