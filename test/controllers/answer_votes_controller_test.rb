require 'test_helper'

class AnswerVotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @answer_vote = answer_votes(:one)
  end

  test "should create answer_vote with positive value" do
    sign_in users(:registered)

    assert_difference('answers(:two).answer_votes.count') do
      post answer_answer_votes_url(answers(:two)), params: { answer_vote: { positive: 'true' } }
    end

    answer_vote = answers(:two).answer_votes.last
    assert_equal 10, answer_vote.trust

    assert_select '.vote-total .small', '1.1'
  end

  test "should create answer_vote with negative value" do
    sign_in users(:registered)

    assert_difference('answers(:two).answer_votes.count') do
      post answer_answer_votes_url(answers(:two)), params: { answer_vote: { positive: 'false' } }
    end

    answer_vote = answers(:two).answer_votes.last
    assert_equal -10, answer_vote.trust

    assert_select '.vote-total .small', '-0.9'
  end

  test "should allow you to vote even if not registered, but should then ask you to register" do
    assert_difference('answers(:two).answer_votes.count TemporaryUser.count') do
      post answer_answer_votes_url(answers(:two)),
        params: { answer_vote: { positive: 'true' } },
        headers: { REMOTE_ADDR: '1.1.1.1' }
    end

    answer_vote = answers(:two).answer_votes.last
    assert_equal 1, answer_vote.trust

    temporary_user = TemporaryUser.last
    assert_equal '1.1.1.1', temporary_user.ip_address
    assert_equal({answer_vote.answer_id.to_s => answer_vote.id}, JSON.parse(temporary_user.votes)['answer'])

    assert_redirected_to join_path(o: 'answerVote', i: answer_vote.id)
  end

  test "should destroy answer_vote" do
    assert_difference('answers(:one).answer_votes.count', -1) do
      delete answer_answer_vote_url(answers(:one), @answer_vote)
    end

    assert_select '.vote-total .small', '0.0'
  end

  test 'updates existing vote if made by same temporary user' do
    answer = answers(:two)
    post answer_answer_votes_url(answer),
      params: { answer_vote: { positive: 'false' } },
      headers: { REMOTE_ADDR: '9.1.1.1' }

    assert_equal 0, answer.reload.vote_total

    assert_no_difference('AnswerVote.count') do
      post answer_answer_votes_url(answer),
        params: { answer_vote: { positive: 'true' } },
        headers: { REMOTE_ADDR: '9.1.1.1' }
    end

    assert_equal 2, answer.reload.vote_total
  end

  test 'updates existing vote if made by same user' do
    user = users(:registered)
    answer = answers(:two)

    sign_in user

    assert_difference('user.answer_votes.count') do
      post answer_answer_votes_url(answer),
        params: { answer_vote: { positive: 'false' } },
        headers: { REMOTE_ADDR: '10.10.10.10' }
    end

    assert_equal -10, user.answer_votes.last.trust

    assert_no_difference('user.answer_votes.count') do
      post answer_answer_votes_url(answer),
        params: { answer_vote: { positive: 'true' } },
        headers: { REMOTE_ADDR: '10.10.10.10' }
    end

    assert_equal 10, user.answer_votes.last.trust
  end
end
