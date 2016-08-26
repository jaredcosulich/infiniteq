require 'test_helper'

class VoteFlowTest < ActionDispatch::IntegrationTest
  def setup
    @topic = topics(:one)
  end

  test "voting on a question anonymously" do
    get "/topics/#{@topic.slug}"
    assert_response :success
    assert_select '.question', 3

    question = @topic.questions.find_by(slug: 'mystring1')
    assert_equal 19, question.vote_total
    assert_difference 'TemporaryUser.count question.question_votes.count' do
      post "/questions/#{question.slug}/question_votes", params: {question_vote: {positive: 'false'}}
    end

    assert temporary_user = TemporaryUser.last
    assert temporary_user.parsed_votes['question'][question.id.to_s].present?

    assert_equal 18, question.reload.vote_total

    follow_redirect!

    assert_select 'p', /-0.1 points./
  end

end
