require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'starts in unverified state' do
    answer = Answer.create(text: 'A new answer')
    assert answer.unverified?
  end

  test 'has a vote_total equal to the trust of the user that created the answer' do
    answer = Answer.create(text: 'A new answer', user: users(:registered))
    assert_equal 100, answer.vote_total
  end

  test 'is verified if vote_total is equal to or greater than 10' do
    answer = Answer.create(text: 'A new answer', user: users(:registered))
    answer.reload
    assert_equal 100, answer.vote_total
    assert answer.verified?
  end
  
end
