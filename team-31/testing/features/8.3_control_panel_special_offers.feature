Feature: Control Panel for Special Offers. Accessibile only for admin

Scenario: Logged in as admin on control panel/special offers, adding two special offer
    Given I am on the homepage
    And I want to sign in as admin
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should see "Hello, Pizza31"
    Then I should see "Control Panel" within ".footer_nav"
    When I go to the control panel page
    When I follow "Special Offers" within ".navbar-collapse"
    Then I should be on the special offers control panel page
    Then I should see "Code Description Discount Used Username"
    Then I should see "PIZZA31 10% Off 0.9 pizza31_shef, all"
    Then I should see "Add Special Offer"
    Then I should see "Edit Special Offer"
    Then I should see "Delete Special Offer"
    When I fill in "code" with "Test name" within ".add_offer"
    When I fill in "description" with "Test description" within ".add_offer"
    When I fill in "discount" with "1.0" within ".add_offer"
    When I select "All" from "username[]" within ".add_offer"
    When I select "pizza_31" from "username[]" within ".add_offer"
    When I press "add-offers" within ".add_offer"
    Then I should see "New special offer has been added into the database"
    Then I should see "TEST NAME Test description 1.0  all"
    When I fill in "code" with "soloyal" within ".add_offer"
    When I fill in "description" with "Loyal" within ".add_offer"
    When I fill in "discount" with "0" within ".add_offer"
    When I select "pizza_31" from "username[]" within ".add_offer"
    When I press "add-offers" within ".add_offer"
    Then I should see "New special offer has been added into the database"
    Then I should see "SOLOYAL Loyal 0.0  pizza_31"
    
  Scenario: Logged in as admin on control panel/special offers, editing a special offer
    Given I am on the homepage
    And I want to sign in as admin
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should see "Hello, Pizza31"
    Then I should see "Control Panel" within ".footer_nav"
    When I go to the control panel page
    When I follow "Special Offers" within ".navbar-collapse"
    Then I should be on the special offers control panel page
    Then I should see "Code Description Discount Used Username"
    Then I should see "PIZZA31 10% Off 0.9 pizza31_shef, all"
    Then I should see "Add Special Offer"
    Then I should see "Edit Special Offer"
    Then I should see "Delete Special Offer"
    When I select "TEST NAME" from "code_id" within ".edit_offer"
    When I press "get-edit-info" within ".edit_offer"
    When I fill in "code" with "Test edit" within ".edit_offer"
    When I fill in "description" with "Test edit desc" within ".edit_offer"
    When I select "All" from "username[]" within ".edit_offer"
    When I press "edit-offer" within ".edit_offer"
    Then I should see "The changes have been saved"
    Then I should see "TEST EDIT Test edit desc 1.0  all"
    Then I should not see "TEST NAME Test description"
    When I select "TEST EDIT" from "code_id" within ".edit_offer"
    When I press "get-edit-info" within ".edit_offer"
    When I fill in "description" with "Test edit desc2" within ".edit_offer"
    When I select "pizza31_shef" from "username[]" within ".add_offer"
    When I press "edit-offer" within ".edit_offer"
    Then I should see "The changes have been saved"
    When I select "TEST EDIT" from "code_id" within ".edit_offer"
    When I press "get-edit-info" within ".edit_offer"
    When I fill in "description" with "Test edit desc" within ".edit_offer"
    When I press "edit-offer" within ".edit_offer"
    Then I should see "The changes have been saved"
    
  Scenario: Logged in as admin on control panel/special offers, editing a duplicate special offer
    Given I am on the homepage
    And I want to sign in as admin
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should see "Hello, Pizza31"
    Then I should see "Control Panel" within ".footer_nav"
    When I go to the control panel page
    When I follow "Special Offers" within ".navbar-collapse"
    Then I should be on the special offers control panel page
    Then I should see "Code Description Discount Used Username"
    Then I should see "PIZZA31 10% Off 0.9 pizza31_shef, all"
    Then I should see "Add Special Offer"
    Then I should see "Edit Special Offer"
    Then I should see "Delete Special Offer"
    When I select "TEST EDIT" from "code_id" within ".edit_offer"
    When I press "get-edit-info" within ".edit_offer"
    When I fill in "code" with "PIZZA31" within ".edit_offer"
    When I press "edit-offer" within ".edit_offer"
    Then I should see "A special offer with this code already exists"
    Then I should not see "PIZZA31 Test edit desc 1.0  all"
    Then I should see "TEST EDIT Test edit desc 1.0  all"
    
  Scenario: Logged in as admin on control panel/special offers, deleting a special offer
    Given I am on the homepage
    And I want to sign in as admin
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should see "Hello, Pizza31"
    Then I should see "Control Panel" within ".footer_nav"
    When I go to the control panel page
    When I follow "Special Offers" within ".navbar-collapse"
    Then I should be on the special offers control panel page
    Then I should see "Code Description Discount Used Username"
    Then I should see "PIZZA31 10% Off 0.9 pizza31_shef, all"
    Then I should see "Add Special Offer"
    Then I should see "Edit Special Offer"
    Then I should see "Delete Special Offer"
    Then I should see "Warning: You will have to add the offer again after deletion"
    When I select "TEST EDIT" from "code_id[]" within ".delete_offer"
    When I check "Confirm for deletion"
    When I press "delete-offers" within ".delete_offer"
    Then I should see "The selected special offers have been deleted"
    Then I should not see "TEST EDIT Test edit desc 2.0"
    