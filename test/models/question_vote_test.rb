require 'test_helper'

class QuestionVoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'updates existing vote if made by same temporary user' do
    question_vote = QuestionVote.create(question: questions(:one), trust: -1)
    temp_user = TemporaryUser.create(ip_address: '10.1.1.1')
    temp_user.add_vote(question_vote)

    assert_no_difference('QuestionVote.count') do
      duplicate_question_vote = QuestionVote.create(question: questions(:one), trust: 1)
      temp_user.add_vote(duplicate_question_vote)
    end

    assert_equal 1, question_vote.reload.trust
  end

  test 'updates existing vote if made by same user' do

  end

end
