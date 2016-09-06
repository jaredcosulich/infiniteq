require 'rails_helper'

feature "Flagging", js: true do
  fixtures :all

  scenario "Flagging a question and removing trust" do
    sign_in users(:another_registered)

    topic = topics(:one)
    question = questions(:one)

    visit("/topics/#{topic.slug}")
    within("#question-#{question.id}") do
      expect(page).to have_content(1.9)
      click_button 'Flag'
    end

    within "##{question.total_identifier}-flag-modal" do
      expect(page).to have_content('Why are you flagging this question?')
      choose('Factually Incorrect')

      choose 'flag_action_trust'
      within '#flag_trust' do
        select('1 trust point')
      end

      click_button 'Flag'
    end

    sleep 5

    within("#question-#{question.id}") do
      expect(page).to_not have_content(1.9)
      expect(page).to have_content(0.9)
      expect(page).to have_content('Reason: Factually Incorrect')
    end

  end

end
