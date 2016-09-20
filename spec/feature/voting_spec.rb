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

    find("#vote-down-question-#{question.id}").click

    within "##{question.total_identifier}verifiedtrue-flag-modal" do
      expect(page).to have_content('Why are you voting down this question?')

      6.times { choose('flag_reason_factually_incorrect') }
      expect(find_field('flag_reason_factually_incorrect')).to be_checked

      fill_in 'flag[details]', with: 'Because it is deserves a flag!'

      6.times { choose 'flag_action_trust' }
      expect(find_field('flag_action_trust')).to be_checked

      within '#flag_trust' do
        select('1 trust point')
      end

      click_button 'Vote Down'
    end

    wait_for_ajax
    expect(page).to_not have_css('.fa-spin')

    expect(page).to have_css("#question-#{question.id}")
    within("#question-#{question.id}") do
      expect(page).to_not have_content(1.9)
      expect(vote_total).to have_content '0.9'
      expect(page).to have_content('Reason: Factually Incorrect')
    end


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
