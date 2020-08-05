Feature: Control Panel for Overview, Sales. Accessibile only for admin

  Scenario: Not logged in
    Given I am on the homepage
    When I go to the control panel page
    Then I should see "TO LET"
    When I go to the menu control panel page
    Then I should see "TO LET"
    When I go to the deals control panel page
    Then I should see "TO LET"
    When I go to the Sheffield orders control panel page
    Then I should see "TO LET"
    When I go to the London orders control panel page
    Then I should see "TO LET"
    When I go to the Sheffield sales control panel page
    Then I should see "TO LET"
    When I go to the London sales control panel page
    Then I should see "TO LET"
    When I go to the special offers control panel page
    Then I should see "TO LET"
    When I go to the accounts control panel page
    Then I should see "TO LET"
    Then I should see "Oops, the page you're looking for does not exist."
    Then I should see "404"
    Then I should see "You may want to head back to the homepage."
    Then I should see "HOME PAGE REPORT PROBLEM"
    Then I should not see the image "../images/logo/logo_text.svg"
    Then I should not see "Menu Accounts Orders Special Offers"

  Scenario: Logged in as normal user
    Given I am on the homepage
    And I want to sign in as user
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should see "Hello, ZerJun Eng"
    Then I should not see "Control Panel" within ".footer_nav"
    When I go to the control panel page
    Then I should see "TO LET"
    When I go to the menu control panel page
    Then I should see "TO LET"
    When I go to the accounts control panel page
    Then I should see "TO LET"
    When I go to the Sheffield orders control panel page
    Then I should see "TO LET"
    When I go to the deals control panel page
    Then I should see "TO LET"
    Then I should see "Oops, the page you're looking for does not exist."
    Then I should see "404"
    Then I should see "You may want to head back to the homepage."
    Then I should see "HOME PAGE REPORT PROBLEM"
    Then I should not see the image "../images/logo/logo_text.svg"
    Then I should not see "Menu Accounts Orders Special Offers"

  Scenario: Logged in as admin and go to the control panel page
    Given I am on the homepage
    And I want to sign in as admin
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should see "Hello, Pizza31"
    Then I should see "Control Panel" within ".footer_nav"
    When I follow "Control Panel" within ".footer_nav"
    Then I should see the image "../images/logo/logo_text.svg"
    Then I should see "Menu Deals"

  Scenario: Logged in as admin on Sheffield orders page
    Given I am on the homepage
    And I want to sign in as admin
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should see "Hello, Pizza31"
    Then I should see "Control Panel" within ".footer_nav"
    When I go to the control panel page
    When I follow "Sheffield Orders" within ".navbar-collapse"
    Then I should be on the Sheffield orders control panel page
    When I follow "Reply" within "#reply-1"

  Scenario: Logged in as admin on London orders page
    Given I am on the homepage
    And I want to sign in as admin
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should see "Hello, Pizza31"
    Then I should see "Control Panel" within ".footer_nav"
    When I go to the control panel page
    When I follow "London Orders" within ".navbar-collapse"
    Then I should be on the London orders control panel page

  Scenario: Logged in as admin on Sheffield sales page
    Given I am on the homepage
    And I want to sign in as admin
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should see "Hello, Pizza31"
    Then I should see "Control Panel" within ".footer_nav"
    When I go to the Sheffield sales control panel page

  Scenario: Logged in as admin on London sales page
    Given I am on the homepage
    And I want to sign in as admin
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should see "Hello, Pizza31"
    Then I should see "Control Panel" within ".footer_nav"
    When I go to the London sales control panel page
