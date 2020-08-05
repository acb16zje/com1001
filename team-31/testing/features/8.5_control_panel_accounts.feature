Feature: Control Panel for Accounts. Accessibile only for admin

  Scenario: Logged in as admin on control panel/accounts, change account status (and back for testing purposes)
    Given I am on the homepage
    And I want to sign in as admin
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should see "Hello, Pizza31"
    Then I should see "Control Panel" within ".footer_nav"
    When I go to the control panel page
    When I follow "Accounts" within ".navbar-collapse"
    Then I should be on the accounts control panel page
    Then I should see "Username Name Email Phone Address Location Postcode Status"
    Then I should see "pizza_31 Pizza31 pizza31@gmail.com 01142332777 Western Bank, S10 2TN Sheffield, England S10 2TN Admin"
    Then I should see "Warning: Experimental Functions"
    When I select "Loyal" from "status-id-pizza_31" within ".accounts"
    When I press "change-account-status-pizza_31" within ".accounts"
    Then I should see "The account status has been changed"
    Then I should see "pizza_31 Pizza31 pizza31@gmail.com 01142332777 Western Bank, S10 2TN Sheffield, England S10 2TN Loyal"
    When I select "Admin" from "status-id-pizza_31" within ".accounts"
    When I press "change-account-status-pizza_31" within ".accounts"
    Then I should see "The account status has been changed"

  Scenario: Logged in as admin on control panel/accounts, delete all accounts
    Given I am on the homepage
    And I want to sign in as admin
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should see "Hello, Pizza31"
    Then I should see "Control Panel" within ".footer_nav"
    When I go to the control panel page
    When I follow "Accounts" within ".navbar-collapse"
    Then I should be on the accounts control panel page
    Then I should see "Username Name Email Phone Address Location Postcode Status"
    Then I should see "pizza_31 Pizza31 pizza31@gmail.com 01142332777 Western Bank, S10 2TN Sheffield, England S10 2TN Admin"
    Then I should see "juneezee ZerJun Eng engzerjun@gmail.com 07874304130 9 Conway Street, S3 7SU Sheffield, England S3 7SU Regular"
    Then I should see "Warning: Experimental Functions"
    Then I should see "Delete all accounts"
    When I check "Confirm for deletion"
    When I press "delete-all" within ".experimental"
    Then I should see "All accounts have been deleted"
    Then I should not see "pizza_31 Pizza31 pizza31@gmail.com 01142332777 Western Bank, S10 2TN Sheffield, England S10 2TN Admin"
    Then I should not see "juneezee ZerJun Eng engzerjun@gmail.com 07874304130 9 Conway Street, S3 7SU Sheffield, England S3 7SU Regular"
