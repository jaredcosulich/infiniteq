require 'test_helper'

class QuestionAndAnswerFlowTest < ActionDispatch::IntegrationTest
  def setup
    @topic = topics(:one)
  end

  test "asking a question about an original topic" do
    sign_in users(:registered)

    get "/topics/#{@topic.slug}"
    assert_response :success
    assert_select 'form textarea:not([value])[name="question[text]"]', true
    assert_select "form input[name='question[topic_id]'][value='#{@topic.id}']", true
    assert_select '.question', 3 #one question (the verified, unanswered one) shows up in two places.

    assert_difference '@topic.questions.count' do
      post "/questions",
        params: { question: { text: "What is the point of this topic?", topic_id: @topic.id } }
    end

    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select 'a', @topic.title

    assert question = @topic.questions.unscoped.last
    assert_select 'h4', question.text

    get "/topics/#{@topic.slug}"
    assert_select '.question', 5 # new question shows up in verified and unanswered

    get "/questions/#{question.slug}"
    assert_select 'form textarea:not([value])[name="answer[text]"]', true
    assert_select "form input[name='answer[question_id]'][value='#{question.id}']", true

    assert_difference 'question.answers.count' do
      post "/answers",
        params: { answer: { text: "There is no point!", question_id: question.id } }
    end

    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select 'h4', question.text
    assert_select 'p', question.answers.first.text
  end

  test 'asking a question anonymously' do
    get "/topics/#{@topic.slug}"
    assert_response :success
    assert_select 'form textarea:not([value])[name="question[text]"]', true
    assert_select "form input[name='question[topic_id]'][value='#{@topic.id}']", true

    assert_difference '@topic.questions.count' do
      post "/questions",
        params: { question: { text: "What is the point of this topic?", topic_id: @topic.id } }
    end

    assert_response :redirect
    follow_redirect!

    assert_select 'h3', /Question Submitted/
    assert_select 'p', /Thank you for your question/
    assert_select 'p', /Would you like to be notified/
    assert_select 'p', /will remain anonymous/
    # assert_select 'p', /anonymous user/
    # assert_select 'p', /"unverified" tab/
    # assert_select 'p', /0.1/
  end


  test 'answering a question anonymously' do
    question = @topic.questions.find_by(slug: 'mystring1')
    get "/questions/#{question.slug}"
    assert_response :success
    assert_select 'form textarea:not([value])[name="answer[text]"]', true
    assert_select "form input[name='answer[question_id]'][value='#{question.id}']", true

    assert_difference 'question.answers.count' do
      post "/answers",
        params: { answer: { text: "Here is the answer", question_id: question.id } }
    end

    assert_response :redirect
    follow_redirect!

    assert_select 'h3', /Answer Submitted/
    assert_select 'p', /Thank you for your answer/
    assert_select 'p', /Would you like to be notified/
    assert_select 'p', /will remain anonymous/
    # assert_select 'p', /anonymous user/
    # assert_select 'p', /"unverified" tab/
    # assert_select 'p', /0.1/
  end

end
