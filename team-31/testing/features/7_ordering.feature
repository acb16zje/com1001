Feature: Ordering

  Scenario: Not logged in on order page
    Given I am on the order page
    Then I should see the image "/images/logo/logo_full_2.svg"
    Then I should see "Sign in with Twitter"
    Then I should see the image "/images/logo/logo_text_white.svg"
    Then I should not see "My Profile My Orders My Offers Sign Out"
    Then I should see "MENU DEALS ORDER" within "#desktop_menu"
    Then I should see "Shopping Basket"
    Then I should see "Item Size Quantity Price"
    Then I should see "Your Shopping Basket is Empty, continue shopping on the"
    Then I should not see "Please complete your profile first before placing an order"
    Then I should see the image "/images/logo/logo_text.svg"
    Then I should see "About Us Contact Us Accessibility" within ".footer_nav"
    Then I should not see "Control Panel" within ".footer_nav"
    Then I should see "Group 31, Team Software Project, 2017" within "footer"

  Scenario: Sheffield user adding and remove pizzas from basket
    Given I am on the order page
    Then I should see "Sign in with Twitter"
    And I want to sign in as user
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should see "Hello, ZerJun Eng"
    Then I should see the image "/images/logo/logo_full_2.svg"
    Then I should see the image "/images/logo/logo_text_white.svg"
    Then I should see "MENU DEALS ORDER" within "#desktop_menu"
    When I follow "ORDER" within "#desktop_menu"
    Then I should be on the order page
    Then I should see "Shopping Basket"
    Then I should see "Item Size Quantity Price"
    Then I should see "Your Shopping Basket is Empty, continue shopping on the"
    Then I should see "0"
    When I go to the menu page
    Then I should see "Add to Basket"
    When I press "add-basket-1" within ".menu"
    Then I should see "1"
    When I press "add-basket-1" within ".menu"
    Then I should see "2"
    When I go to the order page
    When I fill in "quantity" with "10" within ".orders"
    When I press "update-price-1" within ".orders"
    Then I should see "10"
    Then I should see "Delivery Collection"
    When I fill in "quantity" with "0" within ".orders"
    When I press "update-price-1" within ".orders"
    Then I should see "0"
    When I go to the menu page
    When I press "add-basket-1" within ".menu"
    When I press "add-basket-2" within ".menu"
    Then I should see "2"
    When I go to the order page
    When I press "delete-1" within ".orders"
    When I press "delete-1" within ".orders"
    Then I should see "0"
    Then I should see the image "/images/logo/logo_text.svg"
    Then I should see "About Us Contact Us Accessibility" within ".footer_nav"
    Then I should not see "Control Panel" within ".footer_nav"
    Then I should see "Group 31, Team Software Project, 2017" within "footer"

  Scenario: Sheffield user makes 3 orders to become loyal member
    Given I am on the menu page
    And I want to sign in as Sheffield user
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should be on the menu page
    When I select "Medium £11.99" from "size-1" within ".menu"
    When I select "10" from "quantity-1" within ".menu"
    When I press "add-basket-1" within ".menu"
    When I select "Small £8.99" from "size-2" within ".menu"
    When I select "10" from "quantity-2" within ".menu"
    When I press "add-basket-2" within ".menu"
    When I select "10" from "quantity-3" within ".menu"
    When I press "add-basket-3" within ".menu"
    Then I should see "30"
    When I go to the order page
    When I select "PIZZA31" from "special_offer" within ".orders"
    When I select "No cheese" from "customize[]" within ".orders"
    When I select "No sauce" from "customize[]" within ".orders"
    When I select "No onion" from "customize[]" within ".orders"
    When I choose "Delivery" within ".orders"
    When I press "tweet-to-order" within ".orders"
    Then I should see "Your order has been placed"
    Then I should see "0"
    When I go to the menu page
    When I press "add-basket-7" within ".menu"
    Then I should see "1"
    When I go to the order page
    Then I should not see "PIZZA31"
    When I choose "Collection" within ".orders"
    When I press "tweet-to-order" within ".orders"
    Then I should see "Your order has been placed"
    When I go to the menu page
    When I select "Small £8.99" from "size-2" within ".menu"
    When I select "10" from "quantity-2" within ".menu"
    When I press "add-basket-2" within ".menu"
    When I press "add-basket-3" within ".menu"
    When I press "add-basket-4" within ".menu"
    When I press "add-basket-6" within ".menu"
    When I press "add-basket-7" within ".menu"
    When I press "add-basket-8" within ".menu"
    When I press "add-basket-9" within ".menu"
    When I press "add-basket-10" within ".menu"
    When I press "add-basket-11" within ".menu"
    When I go to the order page
    Then I should not see "PIZZA31"
    When I select "Cheddar" from "customize[]" within ".orders"
    When I select "Tomato" from "customize[]" within ".orders"
    When I select "No onion" from "customize[]" within ".orders"
    When I choose "Delivery" within ".orders"
    When I press "tweet-to-order" within ".orders"
    Then I should see "Your order has been placed"
    When I go to the menu page
    When I press "add-basket-9" within ".menu"
    When I go to the order page
    Then I should see "5% off because of your loyalty" within ".order"
    When I press "delete-1" within ".orders"

  Scenario: Loyal Sheffield user rebuying pizza from Order History page
    Given I am on the order history page
    And I want to sign in as Sheffield user
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should see "Hello, Pizza31 SHEF"
    Then I should be on the order history page
    Then I should see "My Orders"
    When I press "tweet-to-order-1" within ".order_history"
    Then I should see "Your order has been placed"

  Scenario: London user ordering one pizza of three different sizes
    Given I am on the order page
    Then I should see "Sign in with Twitter"
    And I want to sign in as London user
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should see "Hello, Pizza31 LON"
    Then I should see "My Profile My Orders My Offers Sign Out"
    Then I should see the image "/images/logo/logo_full_2.svg"
    Then I should see the image "/images/logo/logo_text_white.svg"
    Then I should see "MENU DEALS ORDER" within "#desktop_menu"
    When I follow "ORDER" within "#desktop_menu"
    Then I should be on the order page
    Then I should see "Shopping Basket"
    Then I should see "Item Size Quantity Price"
    Then I should see "Your Shopping Basket is Empty, continue shopping on the"
    When I go to the menu page
    When I select "Large £14.99" from "size-1" within ".menu"
    When I select "10" from "quantity-1" within ".menu"
    When I press "add-basket-1" within ".menu"
    Then I should see "1"
    When I select "Medium £11.99" from "size-1" within ".menu"
    When I select "10" from "quantity-1" within ".menu"
    When I press "add-basket-1" within ".menu"
    Then I should see "2"
    When I select "Small £8.99" from "size-1" within ".menu"
    When I select "10" from "quantity-1" within ".menu"
    When I press "add-basket-1" within ".menu"
    Then I should see "3"
    When I go to the order page
    When I choose "Collection" within ".orders"
    When I press "tweet-to-order" within ".orders"
    When I go to the menu page
    When I press "add-basket-6" within ".menu"
    When I go to the order page
    When I choose "Delivery" within ".orders"
    When I press "tweet-to-order" within ".orders"
    Then I should see "Your order has been placed"
    Then I should see the image "/images/logo/logo_text.svg"
    Then I should see "About Us Contact Us Accessibility" within ".footer_nav"
    Then I should not see "Control Panel" within ".footer_nav"
    Then I should see "Group 31, Team Software Project, 2017" within "footer"
  
  Scenario: Londer user re-ordering with the same order details on Order History page
    Given I am on the order page
    Then I should see "Sign in with Twitter"
    And I want to sign in as London user
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should see "Hello, Pizza31 LON"
    Then I should see "My Profile My Orders My Offers Sign Out"
    Then I should see the image "/images/logo/logo_full_2.svg"
    Then I should see the image "/images/logo/logo_text_white.svg"
    Then I should see "MENU DEALS ORDER" within "#desktop_menu"
    When I follow "ORDER" within "#desktop_menu"
    Then I should be on the order page
    Then I should see "Shopping Basket"
    Then I should see "Item Size Quantity Price"
    Then I should see "Your Shopping Basket is Empty, continue shopping on the"
    When I follow "My Orders" within "#desktop_login_overlay"
    Then I should see "My Orders"
    Then I should be on the order history page
    Then I should see "Order ID Order Type Order Info Date Total Price Order Status Action"
    When I press "tweet-to-order-5" within ".order_history"
    Then I should see "Your order has been placed"

  Scenario: Too far user ordering
    Given I am on the order page
    Then I should see "Sign in with Twitter"
    And I want to sign in as away user
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should see "Hello, Andreak"
    Then I should see the image "/images/logo/logo_full_2.svg"
    Then I should see the image "/images/logo/logo_text_white.svg"
    Then I should see "MENU DEALS ORDER" within "#desktop_menu"
    When I follow "ORDER" within "#desktop_menu"
    Then I should be on the order page
    Then I should see "Shopping Basket"
    Then I should see "Item Size Quantity Price"
    Then I should see "Your Shopping Basket is Empty, continue shopping on the"
    Then I should not see "Delivery"
    Then I should not see "We're sorry. Unfortunately, we do not operate in Manchester, England at the moment."
    Then I should see the image "/images/logo/logo_text.svg"
    Then I should see "About Us Contact Us Accessibility" within ".footer_nav"
    Then I should not see "Control Panel" within ".footer_nav"
    Then I should see "Group 31, Team Software Project, 2017" within "footer"
