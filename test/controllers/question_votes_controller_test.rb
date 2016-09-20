require 'test_helper'

class QuestionVotesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @question_vote = question_votes(:one)
  end

  test "should create question_vote with positive value" do
    sign_in users(:registered)

    assert_difference('questions(:two).question_votes.count') do
      post question_question_votes_url(questions(:two)), params: { question_vote: { positive: 'true' } }
    end

    question_vote = questions(:two).question_votes.last
    assert_equal 100, question_vote.trust

    assert_select '.vote-total .small', '1.1'
  end

  test "should create question_vote with negative value" do
    # Delayed::Worker.delay_jobs = false
    user = users(:registered)
    question = questions(:two)
    sign_in user

    assert_difference('question.question_votes.count') do
      post question_question_votes_url(question), params: { question_vote: { positive: 'false' } }
    end

    question_vote = question.question_votes.last
    assert_equal -100, question_vote.trust

    Delayed::Worker.new.work_off

    assert owner_email = ActionMailer::Base.deliveries.select { |e| e.to == [question.user.email] }.last
    assert_equal "InfiniteQ: Your question was voted down", owner_email.subject
    assert_equal ['support@infiniteq.net'], owner_email.from
    owner_email_content = owner_email.encoded.gsub(/\r\n/, ' ')
    assert owner_email_content.include? '1.0 trust point has been removed from your question'
    assert owner_email_content.include? 'Registered Person voted down your question.'

    assert_select '.vote-total .small', '-0.9'
  end

  test "should allow you to vote even if not registered, but should then ask you to register" do
    assert_difference('questions(:two).question_votes.count TemporaryUser.count') do
      post question_question_votes_url(questions(:two)),
        params: { question_vote: { positive: 'true' } },
        headers: { REMOTE_ADDR: '1.1.1.1' }
    end

    question_vote = questions(:two).question_votes.last
    assert_equal 10, question_vote.trust

    temporary_user = TemporaryUser.last
    assert_equal '1.1.1.1', temporary_user.ip_address
    assert_equal({question_vote.question_id.to_s => question_vote.id}, JSON.parse(temporary_user.votes)['question'])

    assert_redirected_to join_path(o: 'QuestionVote', i: question_vote.id)
  end

  test "should destroy question_vote" do
    question = questions(:one)
    question.update_votes
    assert_equal 190, question.reload.vote_total

    assert_difference('questions(:one).question_votes.count', -1) do
      delete question_question_vote_url(questions(:one), @question_vote)
    end

    assert_select '.vote-total .small', '0.9'
  end

  test 'updates existing vote if made by same temporary user' do
    question = questions(:two)
    post question_question_votes_url(question),
      params: { question_vote: { positive: 'false' } },
      headers: { REMOTE_ADDR: '9.1.1.1' }

    assert_equal 0, question.reload.vote_total

    assert_no_difference('QuestionVote.count') do
      post question_question_votes_url(question),
        params: { question_vote: { positive: 'true' } },
        headers: { REMOTE_ADDR: '9.1.1.1' }
    end

    assert_equal 20, question.reload.vote_total
  end

  test 'updates existing vote if made by same user' do
    user = users(:registered)
    question = questions(:two)

    sign_in user

    assert_difference('user.question_votes.count') do
      post question_question_votes_url(question),
        params: { question_vote: { positive: 'false' } },
        headers: { REMOTE_ADDR: '10.10.10.10' }
    end

    assert_equal -100, user.question_votes.last.trust

    assert_no_difference('user.question_votes.count') do
      post question_question_votes_url(question),
        params: { question_vote: { positive: 'true' } },
        headers: { REMOTE_ADDR: '10.10.10.10' }
    end

    assert_equal 100, user.question_votes.last.trust
  end

end
