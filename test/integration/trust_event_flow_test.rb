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
    assert_equal 1, trust_event.trust
    assert_equal @user, trust_event.user
    assert_equal @user, trust_event.event_user
    assert_equal Question.unscoped.last, trust_event.event_object
  end

  test "creating an answer creates a trust event" do
  end

  test "voting on a question creates a trust event" do
  end

  test "voting on an answer creates a trust event" do
  end
end
