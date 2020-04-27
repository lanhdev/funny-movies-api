# frozen_string_literal: true

Then('user should see sign in form') do
  expect(page).to have_css('input#cucumber-username-form')
  expect(page).to have_css('input#cucumber-username-form')
  expect(page).to have_css('button#cucumber-sign-in-button')
end
