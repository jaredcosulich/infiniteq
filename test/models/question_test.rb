require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'starts in anonymous state' do
    question = Question.create(text: 'A new question')
    assert question.anonymous?
  end

end
