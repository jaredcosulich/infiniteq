require 'rails_helper'

feature "Flagging", js: true do
  fixtures :all

  given(:user) { users(:another_registered) }
  given(:topic) { topics(:one) }
  given(:question) { questions(:one) }

  background do
    sign_in user
  end

  feature 'a question' do
    background do
      visit("/topics/#{topic.slug}")
      within("#question-#{question.id}") do
        expect(page).to have_content(1.9)
        click_button 'Flag'
      end
    end

    scenario "and removing trust" do
      within "##{question.total_identifier}-flag-modal" do
        expect(page).to have_content('Why are you flagging this question?')

        3.times { choose('flag_reason_factually_incorrect') }
        expect(find_field('flag_reason_factually_incorrect')).to be_checked

        3.times { choose 'flag_action_trust' }
        expect(find_field('flag_action_trust')).to be_checked

        within '#flag_trust' do
          select('1 trust point')
        end

        click_button 'Flag'
      end

      wait_for_ajax
      expect(page).to_not have_css('.fa-spin')

      expect(page).to have_css("#question-#{question.id}")
      within("#question-#{question.id}") do
        expect(page).to_not have_content(1.9)
        expect(page).to have_content(0.9)
        expect(page).to have_content('Reason: Factually Incorrect')
      end
    end


    scenario "and marking suspect" do
      expect(page).to have_content('MyString1')

      within "##{question.total_identifier}-flag-modal" do
        expect(page).to have_content('Why are you flagging this question?')

        3.times { choose('flag_reason_factually_incorrect') }
        expect(find_field("flag_reason_factually_incorrect")).to be_checked

        3.times { choose 'flag_action_suspect' }
        expect(find_field("flag_action_suspect")).to be_checked

        click_button 'Flag'
      end

      wait_for_ajax

      expect(question.reload).to be_suspect

      expect(page).to_not have_css('.fa-spin')

      expect(page).to_not have_content('MyString1')
      expect(page).to_not have_content('Reason: Factually Incorrect')

      sleep 1

      click_link 'Other'
      click_link 'Suspect 1'

      expect(page).to have_content('MyString1')
      expect(page).to have_content('Reason: Factually Incorrect')
    end
  end
end

feature "Disputing A Flag", js: true do
  fixtures :all

  given(:user) { users(:registered) }
  given(:flag) { flags(:one) }

  background do
    sign_in user
  end

  scenario "lets you create a flag with negative points" do
    visit "/flags/#{flag.id}"

    expect(page).to have_content('-1.9')

    click_button 'Dispute Flag'

    within "##{flag.question.total_identifier}-flag-modal-dispute" do
      expect(page).to have_content('Flag Dispute')
      expect(page).to have_content('You are disputing this flag: "Factually Incorrect"')

      within '#flag_trust' do
        select('1 trust point')
      end

      click_button 'Dispute Flag'
    end

    wait_for_ajax
    expect(page).to_not have_css('.fa-spin')

    expect(page).to have_content('-0.9')
  end

  scenario "lets you cancel out the flag" do

  end
end
