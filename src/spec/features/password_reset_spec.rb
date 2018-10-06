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
      clear_emails # Clear the message queue
      visit root_url
      click_link 'Forgot Password?'
      expect(page).to have_selector('h1', text: 'Reset Password')
      expect(page).to have_content 'Please enter your email address below and then press "Reset Password".'
      fill_in 'email', with: 'joe@example.com'
      click_button 'Reset Password'
      
      open_email('joe@example.com')
      expect(current_email).to have_selector('h1', text: 'Password Reset Instructions')
      expect(current_email).to have_content 'A request to reset your password has been made.'
      expect(current_email).to have_content 'If you did not make this request, simply ignore this email.'
      expect(current_email).to have_content 'If you did make this request, please follow the link below.'
      current_email.click_link 'Reset Password!'

      expect(page).to have_selector('h1', text: 'Update your password')
      expect(page).to have_content 'Please enter the new password below and then press "Update Password".'
      fill_in 'password', with: 'Daytona 500'
      # click_button 'Update Password'

      clear_emails # Clear the message queue
    end
  end
end
