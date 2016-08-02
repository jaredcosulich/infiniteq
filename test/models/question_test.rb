require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'starts in unverified state' do
    question = Question.create(text: 'A new question')
    assert question.unverified?
  end

end
