Feature: Sign In or Register

  Scenario: User registers by entering username and password
    Given There is no user with username 'newuser'
    When user is on the home page
    Then user enters 'newuser' and 'Abcd1234' to sign in form
    Then user signs in succesfully and should see user control section

  Scenario: User signs in with correct username and password
    Given There is a user with username 'test' and password 'Abcd1234'
    When user is on the home page
    Then user enters 'test' and 'Abcd1234' to sign in form
    Then user signs in succesfully and should see user control section
