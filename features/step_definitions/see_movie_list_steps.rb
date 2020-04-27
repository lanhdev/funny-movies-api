# frozen_string_literal: true

Given('There are some movies which are shared in the movie list') do
  2.times do
    FactoryBot.create(:movie, url: 'https://www.youtube.com/watch?v=sfM7_JLk-84')
  end
end

Then('user could see list of all shared movies') do
  expect(page).to have_css('div#cucumber-movie-item', minimum: 2)
end
