require 'rails_helper'

feature "Voting", js: true do
  fixtures :all

  scenario "Voting down a question you've already voted up" do
    sign_in users(:another_registered)

    topic = topics(:one)
    question = questions(:one)

    visit("/topics/#{topic.slug}")

    vote_total = find("#question-#{question.id} .vote-total .small")
    expect(vote_total).to have_content '1.9'

    click_button("vote-down-question-#{question.id}")

    expect(vote_total).to have_content '-0.1'
  end

  scenario "Voting up a question" do
    sign_in users(:registered)

    question = questions(:two)

    visit("/questions/#{question.slug}")
    expect(page).to have_content question.text
    expect(page).to have_content question.details

    vote_total = find("#question-#{question.id} .vote-total .small")
    expect(vote_total).to have_content '0.1'

    click_button("vote-up-question-#{question.id}")

    expect(vote_total).to have_content '1.1'
  end

  scenario "Voting up an answer" do
    sign_in users(:registered)

    question = questions(:one)
    answer = answers(:two)

    visit("/questions/#{question.slug}")
    expect(page).to_not have_content answer.text

    click_link 'Unverified'
    expect(page).to have_content answer.text

    vote_total = find("#answer-#{answer.id} .vote-total .small")
    expect(vote_total).to have_content '0.1'

    click_button("vote-up-answer-#{answer.id}")

    expect(vote_total).to have_content '1.1'
  end
end
