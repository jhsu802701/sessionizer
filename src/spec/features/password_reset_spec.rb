require 'spec_helper'

feature 'Forgotten password feature' do
  context 'Given an authenticated user' do 
    let(:joe) { create(:joe) }
    background do
      sign_in_user(joe)
      expect(page).to have_content "You're logged in. Welcome back."
      click_link 'Log out'
    end

    scenario 'Shows error message if the user provides an unregistered email address' do
      visit root_url
      click_link 'Forgot Password?'
      expect(page).to have_selector('h1', text: 'Reset Password')
      expect(page).to have_content 'Please enter your email address below and then press "Reset Password".'
      fill_in 'email', with: 'does_not_exist@example.com'
      click_button 'Reset Password'
      expect(page).to have_content 'No participant was found with email address does_not_exist@example.com'
      expect(page).to have_selector('h1', text: 'Reset Password')
      expect(page).to have_content 'Please enter your email address below and then press "Reset Password".'
    end

    scenario 'Registered user can reset password' do
      visit root_url
      click_link 'Forgot Password?'
      expect(page).to have_selector('h1', text: 'Reset Password')
      expect(page).to have_content 'Please enter your email address below and then press "Reset Password".'
      fill_in 'email', with: 'joe@example.com'
    end
  end
end
