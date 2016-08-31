require 'test_helper'

class TrustEventFlowTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:registered)
    sign_in @user
  end

  test "creating a question creates a trust event" do
    assert_difference('@user.trust_events.count TrustEvent.count') do
      post '/questions', params: {question: {text: 'A question'}}
    end

    assert trust_event = @user.trust_events.last
    assert_equal 10, trust_event.trust
    assert_equal @user, trust_event.user
    assert_equal @user, trust_event.event_user
    assert_equal Question.unscoped.last, trust_event.object
  end

  test "creating an answer creates a trust event" do
    assert_difference('@user.trust_events.count TrustEvent.count') do
      post '/answers', params: {answer: {question_id: questions(:two).id, text: 'An answer'}}
    end

    assert trust_event = @user.trust_events.last
    assert_equal 10, trust_event.trust
    assert_equal @user, trust_event.user
    assert_equal @user, trust_event.event_user
    assert_equal Answer.unscoped.last, trust_event.object
  end

  test "voting on a question creates a trust event" do
    question = questions(:two)
    assert_difference('@user.trust_events.count question.user.trust_events.count') do
      post "/questions/#{question.slug}/question_votes", params: {question_vote: {positive: 'false'}}
    end

    assert trust_event = question.user.trust_events.last
    assert_equal -10, trust_event.trust
    assert_equal question.user, trust_event.user
    assert_equal @user, trust_event.event_user
    assert_equal QuestionVote.unscoped.last, trust_event.object

    assert user_trust_event = @user.trust_events.last
    assert_equal 1, user_trust_event.trust
    assert_equal @user, user_trust_event.user
    assert_equal @user, user_trust_event.event_user
    assert_equal QuestionVote.unscoped.last, user_trust_event.object
  end

  test "voting on a question creates a trust event with 0 trust if voter has negative trust" do
    @user.update_column(:trust, -10)

    question = questions(:two)
    post "/questions/#{question.slug}/question_votes", params: {question_vote: {positive: 'false'}}

    assert trust_event = question.user.trust_events.last
    assert_equal 0, trust_event.trust
  end

  test "voting on a question creates a trust event with 1 trust if voter is anonymous" do
    sign_out

    question = questions(:two)
    post "/questions/#{question.slug}/question_votes", params: {question_vote: {positive: 'false'}}

    assert trust_event = question.user.trust_events.last
    assert_equal -1, trust_event.trust
  end

  test "voting on an answer creates a trust event" do
    answer = answers(:two)
    assert_difference('@user.trust_events.count answer.user.trust_events.count') do
      post "/answers/#{answer.id}/answer_votes", params: {answer_vote: {positive: 'true'}}
    end

    assert trust_event = answer.user.trust_events.last
    assert_equal 10, trust_event.trust
    assert_equal answer.user, trust_event.user
    assert_equal @user, trust_event.event_user
    assert_equal AnswerVote.unscoped.last, trust_event.object

    assert user_trust_event = @user.trust_events.last
    assert_equal 1, user_trust_event.trust
    assert_equal @user, user_trust_event.user
    assert_equal @user, user_trust_event.event_user
    assert_equal AnswerVote.unscoped.last, user_trust_event.object
  end
end
