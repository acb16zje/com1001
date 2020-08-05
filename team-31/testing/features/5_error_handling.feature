Feature: Error handling

  Scenario: Not logged in, 404 Page Not Found error, go to homepage
    Given I am on the non-existing page
    Then I should see "Sign in with Twitter"
    Then I should see "TO LET"
    Then I should see "Oops, the page you're looking for does not exist."
    Then I should see "404"
    Then I should see "You may want to head back to the homepage."
    Then I should see "HOME PAGE REPORT PROBLEM"
    Then I should not see "MENU DEALS ORDER"
    Then I should not see "About Us Contact Us Accessibility Control Panel"
    Then I should not see "Group 31, Team Software Project, 2017"
    When I follow "HOME PAGE"
    Then I should not see "Your order has been placed!"
    Then I should not see "You must sign in to place an order."
    Then I should be on the homepage
    Then I should see "Sign in with Twitter"
    Then I should see "MENU DEALS ORDER" within "#desktop_menu"
    Then I should see "OPENING TIMES"
    Then I should see "STORE ADDRESS"
    Then I should see the image "/images/logo/logo_text.svg"
    Then I should see "About Us Contact Us Accessibility" within ".footer_nav"
    Then I should see "Group 31, Team Software Project, 2017" within "footer"

  Scenario: Not logged in, 404 Page Not Found error, go to contact us
    Given I am on the non-existing page
    Then I should see "Sign in with Twitter"
    Then I should see "TO LET"
    Then I should see "Oops, the page you're looking for does not exist."
    Then I should see "404"
    Then I should see "You may want to head back to the homepage."
    Then I should see "HOME PAGE REPORT PROBLEM"
    Then I should not see "MENU DEALS ORDER"
    Then I should not see "Please complete your profile first before placing an order"
    Then I should not see "About Us Contact Us Accessibility Control Panel"
    Then I should not see "Group 31, Team Software Project, 2017"
    When I follow "REPORT PROBLEM"
    Then I should be on the contact us page
    Then I should not see "What Can We Help You With?"
    Then I should see "Please sign in if you want to tweet your inquiry to us"
    Then I should see "Sign in with Twitter"
    Then I should see the image "/images/logo/logo_text.svg"
    Then I should see "About Us Contact Us Accessibility" within ".footer_nav"
    Then I should see "Group 31, Team Software Project, 2017" within "footer"

  Scenario: Not logged in, 500 Internal server error, go to homepage
    Given I am on the server error page
    Then I should see "Sign in with Twitter"
    Then I should see "CLOSED"
    Then I should see "Looks like we're having some server issues."
    Then I should see "500"
    Then I should see "Go back to the previous page and try again."
    Then I should see "HOME PAGE REPORT PROBLEM"
    Then I should not see "MENU DEALS ORDER"
    Then I should not see "About Us Contact Us Accessibility Control Panel"
    Then I should not see "Group 31, Team Software Project, 2017"
    When I follow "HOME PAGE"
    Then I should be on the homepage
    Then I should see "Sign in with Twitter"
    Then I should see "MENU DEALS ORDER" within "#desktop_menu"
    Then I should see "OPENING TIMES"
    Then I should see "STORE ADDRESS"
    Then I should see the image "/images/logo/logo_text.svg"
    Then I should see "About Us Contact Us Accessibility" within ".footer_nav"
    Then I should see "Group 31, Team Software Project, 2017" within "footer"

  Scenario: Not logged in, 500 Internal server error, go to contact us
    Given I am on the server error page
    Then I should see "CLOSED"
    Then I should see "Looks like we're having some server issues."
    Then I should see "500"
    Then I should see "Go back to the previous page and try again."
    Then I should see "HOME PAGE REPORT PROBLEM"
    Then I should not see "MENU DEALS ORDER"
    Then I should not see "About Us Contact Us Accessibility Control Panel"
    Then I should not see "Group 31, Team Software Project, 2017"
    When I follow "REPORT PROBLEM"
    Then I should be on the contact us page
    Then I should not see "What Can We Help You With?"
    Then I should see "Please sign in if you want to tweet your inquiry to us"
    Then I should see "Sign in with Twitter"
    Then I should see the image "/images/logo/logo_text.svg"
    Then I should see "About Us Contact Us Accessibility" within ".footer_nav"
    Then I should see "Group 31, Team Software Project, 2017" within "footer"
