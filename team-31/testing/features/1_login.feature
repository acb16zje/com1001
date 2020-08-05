Feature: Login with OmniAuth Twitter

  Scenario: Admin account and first-time logging in, not providing phone and address
    Given I am on the homepage
    Then I should see the image "/images/logo/logo_full_2.svg"
    Then I should see "Sign in with Twitter"
    Then I should see the image "/images/logo/logo_text_white.svg"
    Then I should see "0"
    And I want to sign in as admin
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should be on the profile page
    Then I should see "Hello, Pizza31"
    Then I should see "MENU DEALS ORDER" within "#desktop_menu"
    Then I should see "Hello Pizza31, please complete your profile first."
    Then I should see "Username: @ Name: Location: Email: Phone: Postcode: Address: Save changes"
    Then I should see the image "/images/logo/logo_text.svg"
    Then I should see "About Us Contact Us Accessibility Control Panel" within ".footer_nav"
    Then I should see "Group 31, Team Software Project, 2017" within "footer"

  Scenario: Admin account and not first-time logging in, no phone and address provided before
    Given I am on the homepage
    Then I should see the image "/images/logo/logo_full_2.svg"
    Then I should see "Sign in with Twitter"
    Then I should see the image "/images/logo/logo_text_white.svg"
    Then I should see "0"
    And I want to sign in as admin
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should be on the profile page
    Then I should see "Hello, Pizza31"
    Then I should see "MENU DEALS ORDER" within "#desktop_menu"
    Then I should see "Hello Pizza31, please complete your profile first."
    Then I should see "Username: @ Name: Location: Email: Phone: Postcode: Address: Save changes"
    Then I should see the image "/images/logo/logo_text.svg"
    Then I should see "About Us Contact Us Accessibility Control Panel" within ".footer_nav"
    Then I should see "Group 31, Team Software Project, 2017" within "footer"

  Scenario: Normal account and first-time logging in, not providing phone and address
    Given I am on the homepage
    Then I should see the image "/images/logo/logo_full_2.svg"
    Then I should see "Sign in with Twitter"
    Then I should see the image "/images/logo/logo_text_white.svg"
    Then I should see "0"
    And I want to sign in as user
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should be on the profile page
    Then I should see "Hello, ZerJun Eng"
    Then I should see "MENU DEALS ORDER"
    Then I should see "Hello ZerJun Eng, please complete your profile first."
    Then I should see "Username: @ Name: Location: Sheffield London Email: Phone: Postcode: Address: Save changes"
    Then I should see "About Us Contact Us Accessibility" within ".footer_nav"
    Then I should not see "Control Panel" within ".footer_nav"
    Then I should see "Group 31, Team Software Project, 2017" within "footer"

  Scenario: Normal account and not first-time logging in, no phone and address provided before
    Given I am on the homepage
    Then I should see the image "/images/logo/logo_full_2.svg"
    Then I should see "Sign in with Twitter"
    Then I should see the image "/images/logo/logo_text_white.svg"
    Then I should see "0"
    And I want to sign in as user
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should be on the profile page
    Then I should see "Hello, ZerJun Eng"
    Then I should see "MENU DEALS ORDER"
    Then I should see "Hello ZerJun Eng, please complete your profile first."
    Then I should see "Username: @ Name: Location: Sheffield London Email: Phone: Postcode: Address: Save changes"
    Then I should see "About Us Contact Us Accessibility" within ".footer_nav"
    Then I should not see "Control Panel" within ".footer_nav"
    Then I should see "Group 31, Team Software Project, 2017" within "footer"

  Scenario: Wrong username or password provided
    Given I am on the homepage
    Then I should see "Sign in with Twitter"
    Then I should see "0"
    And I will provide invalid credentials
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should be on the invalid login page
    Then I should not see "Hello"
    Then I should not see "MENU DEALS ORDER"
    Then I should see "NO ENTRY Username and password does not match"
    Then I should see "Sign in with Twitter"
    Then I should not see "0"
    Then I should not see "About Us Contact Us Accessibility Control Panel"
    Then I should not see "Group 31, Team Software Project, 2017"
