# frozen_string_literal: true

When('user is on the home page') do
  visit 'http://localhost:3001/'
end

Then('user goes to share movie page via link') do
  visit 'http://localhost:3001/share'
end

Then('user is redirected to home page') do
  expect(page).to have_current_path('/')
  expect(page).to have_css('div#cucumber-movie-item')
end
