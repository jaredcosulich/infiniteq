require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'starts in unverified state' do
    question = Question.create(text: 'A new question')
    assert question.unverified?
  end

  test 'has a vote_total equal to the trust of the user that created the question' do
    question = Question.create(text: 'A new question', user: users(:registered))
    assert_equal 100, question.vote_total
  end

  test 'is verified if vote_total is equal to or greater than 10' do
    question = Question.create(text: 'A new question', user: users(:registered))
    question.reload
    assert_equal 100, question.vote_total
    assert question.verified?
  end
end
