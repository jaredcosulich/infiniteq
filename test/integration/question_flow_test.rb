require 'test_helper'

class QuestionFlowTest < ActionDispatch::IntegrationTest
  def setup
    @topic = topics(:one)
  end

  test "asking a question about an original topic" do
    get "/topics/#{@topic.slug}"
    assert_response :success
    assert_select 'form input:not([value])[name="question[text]"]', true
    assert_select "form input[name='question[topic_id]'][value='#{@topic.id}']", true


    assert_difference '@topic.questions.count' do
      post "/questions",
        params: { question: { text: "What is the point of this topic?", topic_id: @topic.id } }
    end

    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select 'h3', @topic.title
    assert_select 'h4', @topic.questions.first.text
  end
end
