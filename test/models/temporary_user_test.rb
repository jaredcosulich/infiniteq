require 'test_helper'

class TemporaryUserTest < ActiveSupport::TestCase

  test '#voted_on? for object and direction' do
    question = questions(:two)

    tu = TemporaryUser.create
    vote = QuestionVote.create(question: question, trust: -1)

    tu.add_vote(vote)

    assert !tu.voted_on?(question, true)
    assert tu.voted_on?(question, false)

    assert !tu.voted_on?(questions(:one), true)
    assert !tu.voted_on?(questions(:one), false)
  end

end
