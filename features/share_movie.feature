Feature: Share movie

  Background:
    Given There is a user with username 'test' and password 'Abcd1234'
  
  Scenario: Signed in user could go to share page and share a movie
    When user is on the home page
    Then user enters 'test' and 'Abcd1234' to sign in form
    Then user signs in succesfully and should see user control section
    Then user clicks on 'Share a movie' button
    Then user should see share a YouTube movie box
    Then user enters a YouTube url 'https://www.youtube.com/watch?v=sfM7_JLk-84' to share form
    Then user clicks on 'Share' button
    Then user is redirected to home page

  Scenario: Visitor accesss to share page and sees warning message
    When user is on the home page
    Then user goes to share movie page via link
    Then user sees a warning message
    Then user enters 'test' and 'Abcd1234' to sign in form
    Then user signs in succesfully and should see user control section
    Then user should see share a YouTube movie box
