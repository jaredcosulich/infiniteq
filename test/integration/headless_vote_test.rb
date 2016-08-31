require 'integration_test_helper'

class HeadlessVoteTest < ActionDispatch::IntegrationTest
  setup do
    Capybara.current_driver = Capybara.javascript_driver
  end

  test 'vote up a question' do
    sign_in users(:another_registered)

    topic = topics(:one)
    question = questions(:one)

    visit("/topics/#{topic.slug}")
    assert page.has_content?('My Account')

    vote_total = find("#question-#{question.id} .vote-total .small")
    assert vote_total.has_content?('1.9')

    click_button("vote-down-question-#{question.id}")

    sleep 1

    vote_total = find("#question-#{question.id} .vote-total .small")
    assert vote_total.has_content?('-0.1')
  end

end
