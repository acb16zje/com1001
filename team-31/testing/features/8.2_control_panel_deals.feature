Feature: Control Panel for Deals. Accessibile only for admin

Scenario: Logged in as admin on control panel/deals, adding two deals
    Given I am on the homepage
    And I want to sign in as admin
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should see "Hello, Pizza31"
    Then I should see "Control Panel" within ".footer_nav"
    When I go to the control panel page
    When I follow "Deals" within ".navbar-collapse"
    Then I should be on the deals control panel page
    Then I should see "Name Description Discount Image"
    Then I should see "Go Large For every two Large pizzas you order, get the third one completely free 1.0"
    Then I should see "Pepsi Lover For every two Medium pizzas you order, get a free 2L Pepsi bottle 1.0"
    Then I should see "Add deals"
    Then I should see "Edit Deals"
    Then I should see "Delete Deals"
    When I fill in "name" with "A Test name" within ".add_deal"
    When I fill in "description" with "Test description" within ".add_deal"
    When I fill in "discount" with "1.0" within ".add_deal"
    When I attach the file "../pizza31/public/images/deals/deal-1.png" to "image_path" within ".add_deal"
    When I press "add-deals" within ".add_deal"
    Then I should see "New deal has been added into the database"
    Then I should see "Test name Test description 1.0"
    Then I should see the image "../images/deals/deal-1.png"
    When I fill in "name" with "A Test name2" within ".add_deal"
    When I fill in "description" with "Test description2" within ".add_deal"
    When I fill in "discount" with "2.0" within ".add_deal"
    When I attach the file "../pizza31/public/images/deals/deal-2.png" to "image_path" within ".add_deal"
    When I press "add-deals" within ".add_deal"
    Then I should see "New deal has been added into the database"
    Then I should see "Test name2 Test description2 2.0"
    Then I should see the image "../images/deals/deal-2.png"
  
  Scenario: Logged in as admin on control panel/deals, editing a deal
    Given I am on the homepage
    And I want to sign in as admin
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should see "Hello, Pizza31"
    Then I should see "Control Panel" within ".footer_nav"
    When I go to the control panel page
    When I follow "Deals" within ".navbar-collapse"
    Then I should be on the deals control panel page
    Then I should see "Name Description Discount Image"
    Then I should see "Go Large For every two Large pizzas you order, get the third one completely free 1.0"
    Then I should see "Pepsi Lover For every two Medium pizzas you order, get a free 2L Pepsi bottle 1.0"
    Then I should see "Test name Test description 1.0"
    Then I should see "Add deals"
    Then I should see "Edit Deals"
    Then I should see "Delete Deals"
    When I select "A Test name" from "deal_id" within ".edit_deal"
    When I press "get-edit-info" within ".edit_deal"
    When I fill in "name" with "A Test edit" within ".edit_deal"
    When I fill in "description" with "Test edit desc" within ".edit_deal"
    When I attach the file "../pizza31/public/images/deals/1.png" to "image_path" within ".edit_deal"
    When I press "edit-deal" within ".edit_deal"
    Then I should see "The changes have been saved"
    Then I should see "A Test edit Test edit desc 1.0"
    Then I should see the image "../images/deals/1.png"
    Then I should not see "A Test name Test description"
    When I select "A Test name2" from "deal_id" within ".edit_deal"
    When I press "get-edit-info" within ".edit_deal"
    When I fill in "description" with "Test edit desc2" within ".edit_deal"
    When I attach the file "../pizza31/public/images/deals/2.png" to "image_path" within ".edit_deal"
    When I press "edit-deal" within ".edit_deal"
    Then I should see "The changes have been saved"
    Then I should see "A Test name2 Test edit desc2 2.0"
    Then I should see the image "../images/deals/2.png"
    Then I should not see "A Test name2 Test description2"
   
  Scenario: Logged in as admin on control panel/deals, editing a duplicate deal
    Given I am on the homepage
    And I want to sign in as admin
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should see "Hello, Pizza31"
    Then I should see "Control Panel" within ".footer_nav"
    When I go to the control panel page
    When I follow "Deals" within ".navbar-collapse"
    Then I should be on the deals control panel page
    Then I should see "Name Description Discount Image"
    Then I should see "Go Large For every two Large pizzas you order, get the third one completely free 1.0"
    Then I should see "Pepsi Lover For every two Medium pizzas you order, get a free 2L Pepsi bottle 1.0"
    Then I should see "A Test edit Test edit desc 1.0"
    Then I should see "Add deals"
    Then I should see "Edit Deals"
    Then I should see "Delete Deals"
    When I select "A Test edit" from "deal_id" within ".edit_deal"
    When I press "get-edit-info" within ".edit_deal"
    When I fill in "name" with "Go Large" within ".edit_deal"
    When I press "edit-deal" within ".edit_deal"
    Then I should see "A deal with this name already exists"
    Then I should not see "Go Large Test edit desc 1.0"
    Then I should see "A Test edit Test edit desc 1.0"
    
  Scenario: Logged in as admin on control panel/deals, deleting a deal
    Given I am on the homepage
    And I want to sign in as admin
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should see "Hello, Pizza31"
    Then I should see "Control Panel" within ".footer_nav"
    When I go to the control panel page
    When I follow "Deals" within ".navbar-collapse"
    Then I should be on the deals control panel page
    Then I should see "Name Description Discount Image"
    Then I should see "Go Large For every two Large pizzas you order, get the third one completely free 1.0"
    Then I should see "Pepsi Lover For every two Medium pizzas you order, get a free 2L Pepsi bottle 1.0"
    Then I should see "Add deals"
    Then I should see "Edit Deals"
    Then I should see "Delete Deals"
    Then I should see "Warning: You will have to add the deals again after deletion"
    When I select "A Test edit" from "deal_id[]" within ".delete_deal"
    When I check "Confirm for deletion"
    When I press "delete-deals" within ".delete_deal"
    Then I should see "The selected deal has been deleted"
    Then I should not see "Test edit Test edit desc 2.0"
    