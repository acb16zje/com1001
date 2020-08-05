Feature: Profile information fill in

  Scenario: Logged out or not logged in, viewing the profile page
    Given I am on the profile page
    Then I should see "0"
    Then I should see "You must sign in to edit your account settings."
    Then I should see "Sign in with Twitter"
    Then I should see "GO TO HOMEPAGE"
    Then I should see "REPORT A PROBLEM"
    Then I should not see "My Profile My Orders My Offers Sign Out"
    Then I should not see "Username: @ Name: Location: Email: Phone: Postcode: Address: Save changes"
    Then I should not see "Control Panel" within ".footer_nav"
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should see "My Profile My Orders My Offers Sign Out"
    Then I should see the image "/images/logo/logo_text.svg"
    Then I should see "About Us Contact Us Accessibility" within ".footer_nav"
    Then I should not see "Control Panel" within ".footer_nav"
    Then I should see "Group 31, Team Software Project, 2017" within "footer"

  Scenario: Admin account logging in, filling in profile information, save changes, logout and login again.
    Given I am on the homepage
    Then I should see "0"
    Then I should see "Sign in with Twitter"
    And I want to sign in as admin
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should see "Hello, Pizza31"
    Then I should see "MENU DEALS ORDER"
    Then I should see "Control Panel" within ".footer_nav"
    When I follow "My Profile" within "#desktop_login_overlay"
    Then I should be on the profile page
    When I fill in "email" with "pizza31@gmail.com" within ".profile"
    When I fill in "phone" with "01142332777" within ".profile"
    When I fill in "postcode" with "s10 2tn"
    When I fill in "address" with "Western Bank, S10 2TN" within ".profile"
    When I press "submit" within ".button"
    Then I should be on the profile page
    Then I should see "Your changes have been saved!"
    Then the "email" field within ".profile" should contain "pizza31@gmail.com"
    Then the "phone" field within ".profile" should contain "01142332777"
    Then the "postcode" field within ".profile" should contain "S10 2TN"
    Then the "address" field within ".profile" should contain "Western Bank, S10 2TN"
    When I follow "Sign Out" within "#desktop_login_overlay"
    Then I should be on the homepage
    When I follow "Sign in with Twitter" within "#desktop_header"
    When I follow "My Profile" within "#desktop_login_overlay"
    Then I should be on the profile page
    Then I should not see "Your changes have been saved!"
    Then the "email" field within ".profile" should contain "pizza31@gmail.com"
    Then the "phone" field within ".profile" should contain "01142332777"
    Then the "postcode" field within ".profile" should contain "S10 2TN"
    Then the "address" field within ".profile" should contain "Western Bank, S10 2TN"
    When I go to the order page
    When I follow "Sign Out" within "#desktop_login_overlay"
    Then I should be on the order page

  Scenario: Normal account logging in, filling in profile information with wrong postcode 
    Given I am on the homepage
    Then I should see "0"
    Then I should see "Sign in with Twitter"
    And I want to sign in as user
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should see "Hello, ZerJun Eng"
    Then I should see "MENU DEALS ORDER"
    Then I should not see "Control Panel" within ".footer_nav"
    When I follow "My Profile" within "#desktop_login_overlay"
    Then I should be on the profile page
    Then I should see "Sheffield London"
    When I choose "Sheffield" within ".profile"
    When I fill in "email" with "engzerjun@gmail.com" within ".profile"
    When I fill in "phone" with "07874304130" within ".profile"
    When I fill in "postcode" with "xfdbbx"
    When I fill in "address" with "9 Conway Street, S3 7SU" within ".profile"
    When I press "submit" within ".button"
    Then I should be on the profile page
    Then I should see "Your changes have been saved!"
    Then I should see "Hello ZerJun Eng, please complete your profile first." within "#desktop_header"
    Then the "email" field within ".profile" should contain "engzerjun@gmail.com"
    Then the "phone" field within ".profile" should contain "07874304130"
    Then the "postcode" field within ".profile" should not contain "xfdbbx"
    Then the "address" field within ".profile" should contain "9 Conway Street, S3 7SU"
    
  Scenario: Normal account logging in, filling in profile information and save changes
    Given I am on the homepage
    Then I should see "0"
    Then I should see "Sign in with Twitter"
    And I want to sign in as user
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should see "Hello, ZerJun Eng"
    Then I should see "MENU DEALS ORDER"
    Then I should not see "Control Panel" within ".footer_nav"
    When I follow "My Profile" within "#desktop_login_overlay"
    Then I should be on the profile page
    Then I should see "Sheffield London"
    When I choose "Sheffield" within ".profile"
    When I fill in "email" with "engzerjun@gmail.com" within ".profile"
    When I fill in "phone" with "07874304130" within ".profile"
    When I fill in "postcode" with "s3 7su"
    When I fill in "address" with "9 Conway Street, S3 7SU" within ".profile"
    When I press "submit" within ".button"
    Then I should be on the profile page
    Then I should see "Your changes have been saved!"
    Then the "email" field within ".profile" should contain "engzerjun@gmail.com"
    Then the "phone" field within ".profile" should contain "07874304130"
    Then the "postcode" field within ".profile" should contain "S3 7SU"
    Then the "address" field within ".profile" should contain "9 Conway Street, S3 7SU"
    When I follow "Sign Out" within "#desktop_login_overlay"
    Then I should be on the homepage
    When I follow "Sign in with Twitter" within "#desktop_header"
    When I follow "My Profile" within "#desktop_login_overlay"
    Then I should be on the profile page
    Then I should not see "Your changes have been saved!"
    Then the "Sheffield" radio button should be checked
    Then the "email" field within ".profile" should contain "engzerjun@gmail.com"
    Then the "phone" field within ".profile" should contain "07874304130"
    Then the "postcode" field within ".profile" should contain "S3 7SU"
    Then the "address" field within ".profile" should contain "9 Conway Street, S3 7SU"

  Scenario: Sheffield account logging in, filling in profile information and save changes
    Given I am on the homepage
    Then I should see "0"
    Then I should see "Sign in with Twitter"
    And I want to sign in as Sheffield user
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should see "Hello, Pizza31 SHEF"
    Then I should see "MENU DEALS ORDER"
    Then I should not see "Control Panel" within ".footer_nav"
    When I follow "My Profile" within "#desktop_login_overlay"
    Then I should be on the profile page
    When I fill in "email" with "andreas@gmail.com" within ".profile"
    When I fill in "phone" with "07874304230" within ".profile"
    When I fill in "postcode" with "s3 7su"
    When I fill in "address" with "9 Conway Street" within ".profile"
    When I press "submit" within ".button"
    Then I should be on the profile page
    Then I should see "Your changes have been saved!"
    Then the "email" field within ".profile" should contain "andreas@gmail.com"
    Then the "phone" field within ".profile" should contain "07874304230"
    Then the "postcode" field within ".profile" should contain "S3 7SU"
    Then the "address" field within ".profile" should contain "9 Conway Street"
    When I follow "Sign Out" within "#desktop_login_overlay"
    Then I should be on the homepage
    When I follow "Sign in with Twitter" within "#desktop_header"
    When I follow "My Profile" within "#desktop_login_overlay"
    Then I should be on the profile page
    Then I should not see "Your changes have been saved!"
    Then the "email" field within ".profile" should contain "andreas@gmail.com"
    Then the "phone" field within ".profile" should contain "07874304230"
    Then the "postcode" field within ".profile" should contain "S3 7SU"
    Then the "address" field within ".profile" should contain "9 Conway Street"

  Scenario: London account logging in, filling in profile information and save changes
    Given I am on the homepage
    Then I should see "0"
    Then I should see "Sign in with Twitter"
    And I want to sign in as London user
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should see "Hello, Pizza31 LON"
    Then I should see "MENU DEALS ORDER"
    Then I should not see "Control Panel" within ".footer_nav"
    When I follow "My Profile" within "#desktop_login_overlay"
    Then I should be on the profile page
    When I fill in "email" with "andreas@gmail.com" within ".profile"
    When I fill in "phone" with "07874304230" within ".profile"
    When I fill in "postcode" with "sw1a 0aa"
    When I fill in "address" with "Westminster" within ".profile"
    When I press "submit" within ".button"
    Then I should be on the profile page
    Then I should see "Your changes have been saved!"
    Then the "email" field within ".profile" should contain "andreas@gmail.com"
    Then the "phone" field within ".profile" should contain "07874304230"
    Then the "postcode" field within ".profile" should contain "SW1A 0AA"
    Then the "address" field within ".profile" should contain "Westminster"
    When I follow "Sign Out" within "#desktop_login_overlay"
    Then I should be on the homepage
    When I follow "Sign in with Twitter" within "#desktop_header"
    When I follow "My Profile" within "#desktop_login_overlay"
    Then I should be on the profile page
    Then I should not see "Your changes have been saved!"
    Then the "email" field within ".profile" should contain "andreas@gmail.com"
    Then the "phone" field within ".profile" should contain "07874304230"
    Then the "postcode" field within ".profile" should contain "SW1A 0AA"
    Then the "address" field within ".profile" should contain "Westminster"

  Scenario: Too far location account logging in, filling in profile information and save changes
    Given I am on the homepage
    Then I should see "0"
    Then I should see "Sign in with Twitter"
    And I want to sign in as away user
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should see "Hello, Andreak"
    Then I should see "MENU DEALS ORDER"
    Then I should not see "Control Panel" within ".footer_nav"
    When I follow "My Profile" within "#desktop_login_overlay"
    Then I should be on the profile page
    When I fill in "email" with "andreas@gmail.com" within ".profile"
    When I fill in "phone" with "07874304230" within ".profile"
    When I fill in "postcode" with "m25 2sw"
    When I fill in "address" with "Heaton Park" within ".profile"
    When I press "submit" within ".button"
    Then I should be on the profile page
    Then I should see "Your changes have been saved!"
    Then the "email" field within ".profile" should contain "andreas@gmail.com"
    Then the "phone" field within ".profile" should contain "07874304230"
    Then the "postcode" field within ".profile" should contain "M25 2SW"
    Then the "address" field within ".profile" should contain "Heaton Park"
    When I follow "Sign Out" within "#desktop_login_overlay"
    Then I should be on the homepage
    When I follow "Sign in with Twitter" within "#desktop_header"
    When I follow "My Profile" within "#desktop_login_overlay"
    Then I should be on the profile page
    Then I should not see "Your changes have been saved!"
    Then the "email" field within ".profile" should contain "andreas@gmail.com"
    Then the "phone" field within ".profile" should contain "07874304230"
    Then the "postcode" field within ".profile" should contain "M25 2SW"
    Then the "address" field within ".profile" should contain "Heaton Park"
