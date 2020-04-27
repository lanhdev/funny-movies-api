# frozen_string_literal: true

Then('user clicks on {string} button') do |button_name|
  click_button button_name
end

Then('user should see share a YouTube movie box') do
  expect(page).to have_css('div#cucumber-share-movie-box')
end

Then('user enters a YouTube url {string} to share form') do |url|
  within('#cucumber-share-movie-box') do
    fill_in 'cucumber-youtube-url', with: url
  end
end

Then('user is redirected to home page') do
  expect(page).to have_current_path('/')
  expect(page).to have_css('div#cucumber-movie-item')
end
