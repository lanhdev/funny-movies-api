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

Then('user sees a warning message') do
  expect(page).to have_css('div#cucumber-unauthorized-text')
  within('#cucumber-unauthorized-text') do
    expect(page).to have_text('401 UNAUTHORIZED')
  end
end
