Feature: Control Panel for Sheffield and London orders. Accessibile only for admin

  Scenario: Marking Sheffield order as active
    Given I am on the homepage
    And I want to sign in as admin
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should see "Hello, Pizza31"
    Then I should see "Control Panel" within ".footer_nav"
    When I go to the control panel page
    When I follow "Sheffield Orders" within ".navbar-collapse"
    Then I should see "1 pizza31_shef Delivery @pizza_31 {Delivery} | Pepperoni, M:10"
    When I check "Confirm" within "#confirm-1"
    When I press "active-1" within ".orders"

  Scenario: Marking Sheffield order as completed
    Given I am on the homepage
    And I want to sign in as admin
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should see "Hello, Pizza31"
    Then I should see "Control Panel" within ".footer_nav"
    When I go to the control panel page
    When I follow "Sheffield Orders" within ".navbar-collapse"
    Then I should see "1 pizza31_shef Delivery @pizza_31 {Delivery} | Pepperoni, M:10"
    When I check "Confirm" within "#confirm-1"
    When I press "completed-1" within ".orders"

  Scenario: Marking Sheffield order as cancelled
    Given I am on the homepage
    And I want to sign in as admin
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should see "Hello, Pizza31"
    Then I should see "Control Panel" within ".footer_nav"
    When I go to the control panel page
    When I follow "Sheffield Orders" within ".navbar-collapse"
    Then I should see "2 pizza31_shef Collection @pizza_31 {Collection} |"
    When I check "Confirm" within "#confirm-2"
    When I press "cancel-2" within ".orders"

  Scenario: Marking London order as active
    Given I am on the homepage
    And I want to sign in as admin
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should see "Hello, Pizza31"
    Then I should see "Control Panel" within ".footer_nav"
    When I go to the control panel page
    When I follow "London Orders" within ".navbar-collapse"
    When I check "Confirm" within "#confirm-5"
    When I press "active-5" within ".orders"

  Scenario: Marking London order as completed
    Given I am on the homepage
    And I want to sign in as admin
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should see "Hello, Pizza31"
    Then I should see "Control Panel" within ".footer_nav"
    When I go to the control panel page
    When I follow "London Orders" within ".navbar-collapse"
    When I check "Confirm" within "#confirm-5"
    When I press "completed-5" within ".orders"

  Scenario: Marking London order as cancelled
    Given I am on the homepage
    And I want to sign in as admin
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should see "Hello, Pizza31"
    Then I should see "Control Panel" within ".footer_nav"
    When I go to the control panel page
    When I follow "London Orders" within ".navbar-collapse"
    When I check "Confirm" within "#confirm-6"
    When I press "cancel-6" within ".orders"
