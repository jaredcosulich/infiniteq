require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "user's trust goes up to 10 when confirmed" do
    user = users(:unconfirmed)
    assert_equal 1, user.trust

    user.confirm
    assert_equal 10, user.trust
  end

  test '#voted_on? for object and direction' do
    question = questions(:two)
    user = users(:registered)
    user.question_votes.destroy_all
    vote = QuestionVote.create(question: question, user: user, trust: -1)

    assert !user.voted_on?(question, true)
    assert user.voted_on?(question, false)
  end

  test '#voted_on? always positive for object created by user' do
    user = users(:registered)
    question = user.questions.create(text: 'A question?')

    assert user.voted_on?(question, true)
    assert !user.voted_on?(question, false)
  end

  test '#voted_on? always negative if not created by user or voted on by user' do
    user = users(:unconfirmed)
    question = user.questions.create(text: 'A question?')

    assert !users(:registered).voted_on?(question, true)
    assert !users(:registered).voted_on?(question, false)
  end
end
