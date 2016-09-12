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

        fill_in 'flag[details]', with: 'Because it is deserves a flag!'

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

      click_link 'Details'

      expect(page).to have_content('Because it is deserves a flag!')
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

    scenario "with errors" do
      within "##{question.total_identifier}-flag-modal" do
        expect(page).to have_content('Why are you flagging this question?')

        3.times { choose('flag_reason_factually_incorrect') }
        expect(find_field('flag_reason_factually_incorrect')).to be_checked

        click_button 'Flag'

        wait_for_ajax

        expect(page).to have_content('please provide an action to take')
      end
    end

    feature 'once flagged' do
      background do
        within "##{question.total_identifier}-flag-modal" do
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
      end

      scenario "can't flag twice" do
        within("#question-#{question.id}") do
          expect(page).to have_content('Reason: Factually Incorrect')
          click_button 'Flag'
        end

        within "##{question.total_identifier}-flag-modal" do
          expect(page).to have_content('You have already flagged this question.')
          expect(page).to_not have_content('Out Of Date')
          expect(page).to_not have_content('What action should be taken?')
          expect(page).to_not have_content('Remove this answer')
          expect(page).to_not have_content('Flag')
        end
      end

      scenario "can delete" do
        within("#question-#{question.id}") do
          expect(page).to have_content('Reason: Factually Incorrect')
          click_link 'Details'
        end

        accept_confirm do
          click_link 'Delete Flag'
        end

        expect(page).to_not have_content('Reason: Factually Incorrect')
        expect(page).to have_css("#question-#{question.id}")
        expect(page).to have_content('1.9')
      end
    end
  end

  feature 'an answer' do
    given(:answer) { question.answers.first }

    background do
      visit("/questions/#{question.slug}")

      within("#answer-#{answer.id}") do
        expect(page).to have_content(1.9)
        click_button 'Flag'
      end
    end

    scenario "and removing trust" do
      within "##{answer.total_identifier}-flag-modal" do
        expect(page).to have_content('Why are you flagging this answer?')

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

      expect(page).to have_css("#answer-#{question.id}")
      within("#answer-#{answer.id}") do
        expect(page).to_not have_content(1.9)
        expect(page).to have_content(0.9)
        expect(page).to have_content('Reason: Factually Incorrect')
      end
    end

    scenario "and marking suspect" do
      expect(page).to have_content('MyAnswer1')

      within "##{answer.total_identifier}-flag-modal" do
        expect(page).to have_content('Why are you flagging this answer?')

        3.times { choose('flag_reason_factually_incorrect') }
        expect(find_field("flag_reason_factually_incorrect")).to be_checked

        3.times { choose 'flag_action_suspect' }
        expect(find_field("flag_action_suspect")).to be_checked

        click_button 'Flag'
      end

      wait_for_ajax

      expect(answer.reload).to be_suspect

      expect(page).to_not have_css('.fa-spin')

      expect(page).to_not have_content('MyAnswer1')
      expect(page).to_not have_content('Reason: Factually Incorrect')

      sleep 1

      click_link 'Other'
      click_link 'Suspect 1'

      expect(page).to have_content('MyAnswer1')
      expect(page).to have_content('Reason: Factually Incorrect')
    end
  end
end

feature "Disputing A Flag", js: true do
  fixtures :all

  given(:user) { users(:registered) }
  given(:flag) { flags(:one) }

  scenario "lets you create a flag with negative points" do
    visit "/flags/#{flag.id}"

    expect(page).to have_content('-0.9')

    click_button 'Dispute Flag'

    within "##{flag.question.total_identifier}-flag-modal-dispute" do
      expect(page).to have_content('Flag Dispute')
      expect(page).to have_content('You are disputing this flag: "Factually Incorrect"')

      fill_in 'flag[details]', with: 'Because it is wrong!'

      click_button 'Dispute Flag'
    end

    wait_for_ajax
    expect(page).to_not have_css('.fa-spin')

    expect(page).to have_content('-0.8')
    expect(page).to have_content('Because it is wrong!')
  end

  scenario "lets you cancel out the flag" do
    sign_in user

    visit "/flags/#{flag.id}"

    expect(page).to have_content('-0.9')

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

    expect(page).to have_content('0.1')

    click_link '< Back To Question'

    expect(page).to have_content('1 disputed')
    expect(page).to_not have_css('.flag-preview')
  end
end

feature "Anonymous Flagging", js: true do
  fixtures :all

  given(:topic) { topics(:one) }
  given(:question) { questions(:one) }

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

        click_button 'Flag'
      end

      wait_for_ajax
      expect(page).to_not have_css('.fa-spin')

      expect(page).to have_css("#question-#{question.id}")
      within("#question-#{question.id}") do
        expect(page).to_not have_content(1.9)
        expect(page).to have_content(1.8)
        expect(page).to have_content('Reason: Factually Incorrect')
        expect(page).to have_content('0.1 trust points removed.')
      end
    end

    scenario "and marking suspect is not allowed" do
      expect(page).to have_content('MyString1')

      within "##{question.total_identifier}-flag-modal" do
        expect(page).to have_content('Why are you flagging this question?')
        expect(page).to have_css("input[type='radio'][value='suspect'][disabled='disabled']")
      end
    end

    feature 'once flagged' do
      background do
        within "##{question.total_identifier}-flag-modal" do
          expect(page).to have_content('Why are you flagging this question?')

          3.times { choose('flag_reason_factually_incorrect') }
          expect(find_field('flag_reason_factually_incorrect')).to be_checked

          3.times { choose 'flag_action_trust' }
          expect(find_field('flag_action_trust')).to be_checked

          click_button 'Flag'
        end

        wait_for_ajax
        expect(page).to_not have_css('.fa-spin')

        expect(page).to have_css("#question-#{question.id}")
      end

      scenario "can't flag twice" do
        within("#question-#{question.id}") do
          expect(page).to have_content('Reason: Factually Incorrect')
          click_button 'Flag'
        end

        within "##{question.total_identifier}-flag-modal" do
          expect(page).to have_content('You have already flagged this question.')
          expect(page).to_not have_content('Flag')
        end
      end

      scenario "can delete" do
        within("#question-#{question.id}") do
          expect(page).to have_content('Reason: Factually Incorrect')
          click_link 'Details'
        end

        accept_confirm do
          click_link 'Delete Flag'
        end

        expect(page).to_not have_content('Reason: Factually Incorrect')
        expect(page).to have_css("#question-#{question.id}")
        expect(page).to have_content('1.9')
      end
    end
  end
end
