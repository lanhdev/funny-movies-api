Feature: See movie list

  Background:
    Given There are some movies which are shared in the movie list
  
  Scenario: Visitor could go to home page and see the movie list
    When user is on the home page
    Then user could see list of all shared movies
