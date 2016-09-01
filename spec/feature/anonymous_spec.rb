require 'rails_helper'

feature "Anonymous Interactions", js: true do
  fixtures :all

  scenario "Asking a question when anonymous" do
    topic = topics(:one)

    visit("/topics/#{topic.slug}")

    fill_in 'question[text]', with: 'How do you ask a question?'
    find('.ask_a_question span.btn-action').click

    expect(page).to have_content('Is this a real question?')
    find('.modal span.btn-default').click

    expect(page).to_not have_content('Is this a real question?')
    expect(page).to_not have_content('Anonymous Question Recorded')

    fill_in 'question[text]', with: 'How do you ask a question?'
    find('.ask_a_question span.btn-action').click

    expect(page).to have_content('Is this a real question?')
    click_button 'Yes, it is a real question'

    expect(page).to_not have_content('Is this a real question?')
    expect(page).to have_content('Anonymous Question Submitted')
  end

end
