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

    question = Question.unscoped.last
    expect(question.text).to eq('How do you ask a question?')
    expect(question.user).to be nil

    temp_user = TemporaryUser.unscoped.last
    expect(temp_user.parsed_questions).to include(question.id.to_s)

    fill_in 'user[email]', with: 'email@example.com'
    click_button 'Save'

    expect(page).to have_content('A message with a confirmation link has been sent to your email address.')

    user = User.unscoped.last
    expect(user.email).to eq('email@example.com')

    expect(question.reload.user).to eq(user)
    expect(TemporaryUser.find_by_id(temp_user.id)).to be nil
    expect(user.questions).to include(question)
  end

end
