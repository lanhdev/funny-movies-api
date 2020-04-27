Feature: Sign Out

  Scenario: User signs in with correct username and password and then signs out
    Given There is a user with username 'test' and password 'Abcd1234'
    When user is on the home page
    Then user enters 'test' and 'Abcd1234' to sign in form
    Then user signs in succesfully and should see user control section
    Then user clicks on 'Logout' button
    Then user should see sign in form
