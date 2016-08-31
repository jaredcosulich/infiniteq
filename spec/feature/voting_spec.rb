require 'rails_helper'

feature "Voting", js: true do
  fixtures :all

  scenario "Voting down a question you've already voted up" do
    sign_in users(:another_registered)

    topic = topics(:one)
    question = questions(:one)

    visit("/topics/#{topic.slug}")
    assert page.has_content?('My Account')

    vote_total = find("#question-#{question.id} .vote-total .small")
    expect(vote_total).to have_content '1.9'

    click_button("vote-down-question-#{question.id}")

    expect(vote_total).to have_content '-0.1'
  end
end
