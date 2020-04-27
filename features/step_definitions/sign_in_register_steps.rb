# frozen_string_literal: true

Given('There is no user with username {string}') do |username|
  user = User.find_by(username: username)
  expect(user).to eq nil
end

Given('There is a user with username {string} and password {string}') do |username, password|
  @user = FactoryBot.create(
    :user,
    username: username,
    password: password,
    password_confirmation: password
  )
end

When('user is on the home page') do
  visit 'http://localhost:3001/'
end

Then('user enters {string} and {string} to sign in form') do |username, password|
  within('#cucumber-user-section') do
    fill_in 'cucumber-username-form', with: username
    fill_in 'cucumber-password-form', with: password
  end
  click_button 'Log In / Register'
end

Then('user signs in succesfully and should see user control section') do
  expect(page).to have_css('div#cucumber-welcome-user')
  expect(page).to have_css('button#cucumber-share-button')
  expect(page).to have_css('button#cucumber-logout-button')
end
