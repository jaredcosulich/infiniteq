module DeviseHelpers

  def sign_in(user)
    visit  '/users/sign_in'

    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: 'password'

    click_button 'Log In'

    expect(page).to have_content 'Signed in successfully.'
  end

  def sign_out
    click_button 'Log Out'
    expect(page).to have_content 'Signed out successfully.'
  end

end
