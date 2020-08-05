Feature: Logout

  Scenario: Not logged in but tries to logout
    Given I am on the homepage
    Then I should see "0"
    Then I should not see "Hello"
    Then I should not see "My Profile My Orders My Offers Sign Out"
    Then I should not see "Control Panel" within ".footer_nav"
    When I go to the logout page
    Then I should see "Sign in with Twitter"
    Then I should see "TO LET"
    Then I should see "Oops, the page you're looking for does not exist."
    Then I should see "404"
    Then I should see "You may want to head back to the homepage."
    Then I should see "HOME PAGE REPORT PROBLEM"
    Then I should not see the image "/images/logo/logo_text.svg"
    Then I should not see "About Us Contact Us Accessibility"
    Then I should not see "Group 31, Team Software Project, 2017"

  Scenario: Admin account logout
    Given I am on the homepage
    Then I should see "0"
    And I want to sign in as admin
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should see "Control Panel" within ".footer_nav"
    Then I should see "Hello, Pizza31"
    Then I should see "My Profile My Orders My Offers Sign Out" within "#desktop_login_overlay"
    When I follow "Sign Out" within "#desktop_login_overlay"
    Then I should not see "Hello, Pizza31"
    Then I should not see "My Profile My Orders My Offers Sign Out"
    Then I should not see "Control Panel" within ".footer_nav"
    Then I should see "Sign in with Twitter" within "#desktop_header"
    Then I should be on the homepage
    Then I should see "MENU DEALS ORDER" within "#desktop_menu"
    Then I should see the image "/images/logo/logo_text.svg"
    Then I should see "About Us Contact Us Accessibility" within ".footer_nav"
    Then I should see "Group 31, Team Software Project, 2017" within "footer"

  Scenario: Normal account logout
    Given I am on the homepage
    And I want to sign in as user
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should not see "Control Panel" within ".footer_nav"
    Then I should see "Hello, ZerJun Eng"
    Then I should see "My Profile My Orders My Offers Sign Out" within "#desktop_login_overlay"
    When I follow "Sign Out" within "#desktop_login_overlay"
    Then I should not see "Hello, ZerJun Eng"
    Then I should not see "My Profile My Orders My Offers Sign Out"
    Then I should see "Sign in with Twitter" within "#desktop_header"
    Then I should see "MENU DEALS ORDER"
    Then I should see "OPENING TIME"
    Then I should be on the homepage
    Then I should see "MENU DEALS ORDER" within "#desktop_menu"
    Then I should see "OPENING TIME"
    Then I should see the image "/images/logo/logo_text.svg"
    Then I should see "About Us Contact Us Accessibility" within ".footer_nav"
    Then I should not see "Control Panel" within ".footer_nav"
    Then I should see "Group 31, Team Software Project, 2017" within "footer"
