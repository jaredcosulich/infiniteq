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

  test '#voted_on? always positive for question created by temporary_user' do
    tu = TemporaryUser.create
    question = Question.create(text: 'A question?')

    tu.add_question(question)

    assert tu.voted_on?(question, true)
    assert !tu.voted_on?(question, false)
  end


  test '#voted_on? always positive for answer created by temporary_user' do
    tu = TemporaryUser.create
    answer = questions(:one).answers.create(text: 'An answer')

    tu.add_answer(answer)

    assert tu.voted_on?(answer, true)
    assert !tu.voted_on?(answer, false)
  end

end
