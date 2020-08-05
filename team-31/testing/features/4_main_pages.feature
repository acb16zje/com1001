Feature: All the main pages on the website

  Scenario: Not logged in on homepage
    Given I am on the homepage
    Then I should see the image "/images/logo/logo_full_2.svg"
    Then I should see "Sign in with Twitter"
    Then I should see the image "/images/logo/logo_text_white.svg"
    Then I should see "MENU DEALS ORDER" within "#desktop_menu"
    Then I should see the image "/images/deals/deal-1.png"
    Then I should see the image "/images/deals/deal-2.png"
    Then I should see the image "/images/deals/deal-3.png"
    Then I should see "OPENING TIMES"
    Then I should see "STORE ADDRESS"
    Then I should see the image "/images/logo/logo_text.svg"
    Then I should see "About Us Contact Us Accessibility" within ".footer_nav"
    Then I should not see "Control Panel" within ".footer_nav"
    Then I should see "Group 31, Team Software Project, 2017" within "footer"

  Scenario: Not logged in on menu page
    Given I am on the menu page
    Then I should see the image "/images/logo/logo_full_2.svg"
    Then I should see "Sign in with Twitter"
    Then I should see the image "/images/logo/logo_text_white.svg"
    Then I should see "MENU DEALS ORDER" within "#desktop_menu"
    Then I should see "Our Menu"
    Then I should see the image "/images/pizza/london/texas_bbq.png"
    Then I should see "Texas BBQ"
    Then I should see "BBQ sauce topped with smoky bacon"
    Then I should see "Sign in to Add to Basket"
    Then I should not see "Large £14.99"
    Then I should not see "Small £8.99"
    Then I should see the image "/images/pizza/pepperoni.png"
    Then I should see the image "/images/pizza/sheffield/mighty_meaty.png"
    Then I should see the image "/images/pizza/new_yorker.png"
    Then I should see the image "/images/pizza/ham_pineapple.png"
    Then I should see the image "/images/logo/logo_text.svg"
    Then I should see "About Us Contact Us Accessibility" within ".footer_nav"
    Then I should not see "Control Panel" within ".footer_nav"
    Then I should see "Group 31, Team Software Project, 2017" within "footer"

  Scenario: Not logged in on deals page
    Given I am on the deals page
    Then I should see the image "/images/logo/logo_full_2.svg"
    Then I should see "Sign in with Twitter"
    Then I should see the image "/images/logo/logo_text_white.svg"
    Then I should see "MENU DEALS ORDER" within "#desktop_menu"
    Then I should see "Daily Deals"
    Then I should see the image "/images/deals/deal-1.png"
    Then I should see the image "/images/deals/deal-2.png"
    Then I should see the image "/images/deals/deal-3.png"
    Then I should see the image "/images/logo/logo_text.svg"
    Then I should see "About Us Contact Us Accessibility" within ".footer_nav"
    Then I should not see "Control Panel" within ".footer_nav"
    Then I should see "Group 31, Team Software Project, 2017" within "footer"

  Scenario: Not logged in on order page
    Given I am on the order page
    Then I should see the image "/images/logo/logo_full_2.svg"
    Then I should see "Sign in with Twitter"
    Then I should see the image "/images/logo/logo_text_white.svg"
    Then I should see "MENU DEALS ORDER" within "#desktop_menu"
    Then I should see "Shopping Basket"
    Then I should see "Your Shopping Basket is Empty, continue shopping on"
    Then I should see "You must sign in to place an order."
    Then I should see "Sign in with Twitter"
    Then I should not see "Please complete your profile first before placing an order"
    Then I should see the image "/images/logo/logo_text.svg"
    Then I should see "About Us Contact Us Accessibility" within ".footer_nav"
    Then I should not see "Control Panel" within ".footer_nav"
    Then I should see "Group 31, Team Software Project, 2017" within "footer"

  Scenario: Not logged in on about us page
    Given I am on the about us page
    Then I should see the image "/images/logo/logo_full_2.svg"
    Then I should see "Sign in with Twitter"
    Then I should see the image "/images/logo/logo_text_white.svg"
    Then I should see "MENU DEALS ORDER" within "#desktop_menu"
    Then I should see "Who are Pizza31?"
    Then I should see "Yoonji Kim"
    Then I should see "Zer Jun Eng"
    Then I should see "Andreas Ioannou"
    Then I should see "Hin Chak Lau"
    Then I should see "Yujia Cheng"
    Then I should see "Hok Hin Yu"
    Then I should see the image "/images/logo/logo_text.svg"
    Then I should see "About Us Contact Us Accessibility" within ".footer_nav"
    Then I should not see "Control Panel" within ".footer_nav"
    Then I should see "Group 31, Team Software Project, 2017" within "footer"

  Scenario: Not logged in on contact us page
    Given I am on the contact us page
    Then I should see the image "/images/logo/logo_full_2.svg"
    Then I should see "Sign in with Twitter"
    Then I should see the image "/images/logo/logo_text_white.svg"
    Then I should see "MENU DEALS ORDER" within "#desktop_menu"
    Then I should not see "What Can We Help You With?"
    Then I should see "Please sign in if you want to tweet your inquiry to us"
    Then I should see the image "/images/logo/logo_text.svg"
    Then I should see "About Us Contact Us Accessibility" within ".footer_nav"
    Then I should not see "Control Panel" within ".footer_nav"
    Then I should see "Group 31, Team Software Project, 2017" within "footer"

  Scenario: Not logged in on accessibility page
    Given I am on the accessibility page
    Then I should see the image "/images/logo/logo_full_2.svg"
    Then I should see "Sign in with Twitter"
    Then I should see the image "/images/logo/logo_text_white.svg"
    Then I should see "MENU DEALS ORDER" within "#desktop_menu"
    Then I should see "Accessibility Statement"
    Then I should see "Our Commitment to Accessibility"
    Then I should see "Having Difficulties?"
    Then I should see the image "/images/logo/logo_text.svg"
    Then I should see "About Us Contact Us Accessibility" within ".footer_nav"
    Then I should not see "Control Panel" within ".footer_nav"
    Then I should see "Group 31, Team Software Project, 2017" within "footer"
    When I follow "Contact Us" within "section"
    Then I should be on the contact us page

  Scenario: Admin logged in on homepage
    Given I am on the homepage
    Then I should see "Sign in with Twitter"
    And I want to sign in as admin
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should see "Hello, Pizza31"
    Then I should see the image "/images/logo/logo_full_2.svg"
    Then I should see the image "/images/logo/logo_text_white.svg"
    Then I should see "MENU DEALS ORDER" within "#desktop_menu"
    When I follow image link "Pizza31 text logo"
    Then I should be on the homepage
    Then I should see the image "/images/deals/deal-1.png"
    Then I should see the image "/images/deals/deal-2.png"
    Then I should see the image "/images/deals/deal-3.png"
    Then I should see "OPENING TIMES"
    Then I should see "STORE ADDRESS"
    Then I should see the image "/images/logo/logo_text.svg"
    Then I should see "About Us Contact Us Accessibility Control Panel" within ".footer_nav"
    Then I should see "Group 31, Team Software Project, 2017" within "footer"

  Scenario: Admin logged in on menu page
    Given I am on the menu page
    Then I should see "Sign in with Twitter"
    And I want to sign in as admin
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should see "Hello, Pizza31"
    Then I should see the image "/images/logo/logo_full_2.svg"
    Then I should see the image "/images/logo/logo_text_white.svg"
    Then I should see "MENU DEALS ORDER" within "#desktop_menu"
    When I follow "MENU" within "#desktop_menu"
    Then I should be on the menu page
    Then I should see "Our Menu"
    Then I should not see the image "/images/pizza/london/texas_bbq.png"
    Then I should see the image "/images/pizza/pepperoni.png"
    Then I should see "Pepperoni"
    Then I should see "Regular base with pepperoni topping"
    Then I should not see "Sign in to Add to Basket"
    Then I should see "1 2 3 4 5 6 7 8 9"
    Then I should see "Large £18.99"
    Then I should see "Medium £11.99"
    Then I should see "Small £10.99"
    Then I should see the image "/images/pizza/sheffield/mighty_meaty.png"
    Then I should see the image "/images/pizza/new_yorker.png"
    Then I should see the image "/images/pizza/ham_pineapple.png"
    Then I should see the image "/images/logo/logo_text.svg"
    Then I should see "About Us Contact Us Accessibility Control Panel" within ".footer_nav"
    Then I should see "Group 31, Team Software Project, 2017" within "footer"

  Scenario: Admin logged in on deals page
    Given I am on the deals page
    Then I should see "Sign in with Twitter"
    And I want to sign in as admin
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should see "Hello, Pizza31"
    Then I should see the image "/images/logo/logo_full_2.svg"
    Then I should see the image "/images/logo/logo_text_white.svg"
    Then I should see "MENU DEALS ORDER" within "#desktop_menu"
    When I follow "DEALS" within "#desktop_menu"
    Then I should be on the deals page
    Then I should see "Daily Deals"
    Then I should see the image "/images/deals/deal-1.png"
    Then I should see the image "/images/deals/deal-2.png"
    Then I should see the image "/images/deals/deal-3.png"
    Then I should see the image "/images/logo/logo_text.svg"
    Then I should see "About Us Contact Us Accessibility Control Panel" within ".footer_nav"
    Then I should see "Group 31, Team Software Project, 2017" within "footer"

  Scenario: Admin logged in on order page
    Given I am on the order page
    Then I should see "Sign in with Twitter"
    And I want to sign in as admin
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should see "Hello, Pizza31"
    Then I should see the image "/images/logo/logo_full_2.svg"
    Then I should see the image "/images/logo/logo_text_white.svg"
    Then I should see "MENU DEALS ORDER" within "#desktop_menu"
    When I follow "ORDER" within "#desktop_menu"
    Then I should be on the order page
    Then I should see "Shopping Basket"
    Then I should see "Your Shopping Basket is Empty, continue shopping on the"
    Then I should not see "You must sign in to place an order"
    Then I should see the image "/images/logo/logo_text.svg"
    Then I should see "About Us Contact Us Accessibility Control Panel" within ".footer_nav"
    Then I should see "Group 31, Team Software Project, 2017" within "footer"

  Scenario: Admin logged in on about us page
    Given I am on the about us page
    Then I should see "Sign in with Twitter"
    And I want to sign in as admin
    When I follow "Sign in with Twitter" within "#desktop_header"
    When I follow "About Us" within ".footer_nav"
    Then I should be on the about us page
    Then I should see "Hello, Pizza31"
    Then I should see the image "/images/logo/logo_full_2.svg"
    Then I should see the image "/images/logo/logo_text_white.svg"
    Then I should see "MENU DEALS ORDER" within "#desktop_menu"
    Then I should see "Who are Pizza31?"
    Then I should see "Yoonji Kim"
    Then I should see "Zer Jun Eng"
    Then I should see "Andreas Ioannou"
    Then I should see "Hin Chak Lau"
    Then I should see "Yujia Cheng"
    Then I should see "Hok Hin Yu"
    Then I should see the image "/images/logo/logo_text.svg"
    Then I should see "About Us Contact Us Accessibility Control Panel" within ".footer_nav"
    Then I should see "Group 31, Team Software Project, 2017" within "footer"

  Scenario: Admin logged in on contact us page
    Given I am on the contact us page
    Then I should see "Sign in with Twitter"
    And I want to sign in as admin
    When I follow "Sign in with Twitter" within "#desktop_header"
    When I follow "Contact Us" within ".footer_nav"
    Then I should be on the contact us page
    Then I should see "Hello, Pizza31"
    Then I should see the image "/images/logo/logo_full_2.svg"
    Then I should see the image "/images/logo/logo_text_white.svg"
    Then I should see "MENU DEALS ORDER" within "#desktop_menu"
    Then I should see "What Can We Help You With?"
    Then I should see "Tweet"
    When I fill in "comments" with "Feedback" within ".textarea"
    When I press "submit" within ".misc"
    Then I should see "Thank you"
    Then I should see the image "/images/logo/logo_text.svg"
    Then I should see "About Us Contact Us Accessibility Control Panel" within ".footer_nav"
    Then I should see "Group 31, Team Software Project, 2017" within "footer"

  Scenario: Admin logged in on accessibility page
    Given I am on the accessibility page
    Then I should see "Sign in with Twitter"
    And I want to sign in as admin
    When I follow "Sign in with Twitter" within "#desktop_header"
    When I follow "Accessibility" within ".footer_nav"
    Then I should be on the accessibility page
    Then I should see "Hello, Pizza31"
    Then I should see the image "/images/logo/logo_full_2.svg"
    Then I should see the image "/images/logo/logo_text_white.svg"
    Then I should see "MENU DEALS ORDER" within "#desktop_menu"
    Then I should see "Accessibility Statement"
    Then I should see "Our Commitment to Accessibility"
    Then I should see "Having Difficulties?"
    Then I should see the image "/images/logo/logo_text.svg"
    Then I should see "About Us Contact Us Accessibility Control Panel" within ".footer_nav"
    Then I should see "Group 31, Team Software Project, 2017" within "footer"
    When I follow "Contact Us" within "section"
    Then I should be on the contact us page

  Scenario: User logged in on homepage
    Given I am on the homepage
    Then I should see "Sign in with Twitter"
    And I want to sign in as user
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should see "Hello, ZerJun Eng"
    Then I should see the image "/images/logo/logo_full_2.svg"
    Then I should see the image "/images/logo/logo_text_white.svg"
    Then I should see "MENU DEALS ORDER" within "#desktop_menu"
    When I follow image link "Pizza31 text logo"
    Then I should be on the homepage
    Then I should see the image "/images/deals/deal-1.png"
    Then I should see the image "/images/deals/deal-2.png"
    Then I should see the image "/images/deals/deal-3.png"
    Then I should see "OPENING TIMES"
    Then I should see "STORE ADDRESS"
    Then I should see the image "/images/logo/logo_text.svg"
    Then I should see "About Us Contact Us Accessibility" within ".footer_nav"
    Then I should not see "Control Panel" within ".footer_nav"
    Then I should see "Group 31, Team Software Project, 2017" within "footer"

  Scenario: User logged in on menu page
    Given I am on the menu page
    Then I should see "Sign in with Twitter"
    And I want to sign in as user
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should see "Hello, ZerJun Eng"
    Then I should see the image "/images/logo/logo_full_2.svg"
    Then I should see the image "/images/logo/logo_text_white.svg"
    Then I should see "MENU DEALS ORDER" within "#desktop_menu"
    When I follow "MENU" within "#desktop_menu"
    Then I should be on the menu page
    Then I should see "Sheffield"
    Then I should not see "London"
    Then I should see "Our Menu"
    Then I should not see the image "/images/pizza/london/texas_bbq.png"
    Then I should see the image "/images/pizza/pepperoni.png"
    Then I should see the image "/images/pizza/sheffield/mighty_meaty.png"
    Then I should see "Mighty Meaty"
    Then I should see "Tomato sauce, pepperoni, ham"
    Then I should see "Large £14.99"
    Then I should see the image "/images/pizza/new_yorker.png"
    Then I should see the image "/images/pizza/ham_pineapple.png"
    Then I should see the image "/images/logo/logo_text.svg"
    Then I should see "About Us Contact Us Accessibility" within ".footer_nav"
    Then I should not see "Control Panel" within ".footer_nav"
    Then I should see "Group 31, Team Software Project, 2017" within "footer"

  Scenario: London user logged in on menu page
    Given I am on the menu page
    Then I should see "Sign in with Twitter"
    And I want to sign in as London user
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should see "Hello, Pizza31 LON"
    Then I should see the image "/images/logo/logo_full_2.svg"
    Then I should see the image "/images/logo/logo_text_white.svg"
    Then I should see "MENU DEALS ORDER" within "#desktop_menu"
    When I follow "MENU" within "#desktop_menu"
    Then I should be on the menu page
    Then I should not see "Sheffield"
    Then I should see "London"
    Then I should see "Our Menu"
    Then I should see the image "/images/pizza/london/texas_bbq.png"
    Then I should see the image "/images/pizza/pepperoni.png"
    Then I should not see the image "/images/pizza/sheffield/mighty_meaty.png"
    Then I should not see "Mighty Meaty"
    Then I should see "Texas BBQ"
    Then I should see "succulent roast chicken"
    Then I should see "Large £14.99"
    Then I should see the image "/images/pizza/new_yorker.png"
    Then I should see the image "/images/pizza/ham_pineapple.png"
    Then I should see the image "/images/logo/logo_text.svg"
    Then I should see "About Us Contact Us Accessibility" within ".footer_nav"
    Then I should not see "Control Panel" within ".footer_nav"
    Then I should see "Group 31, Team Software Project, 2017" within "footer"

  Scenario: User logged in on deals page
    Given I am on the deals page
    Then I should see "Sign in with Twitter"
    And I want to sign in as user
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should see "Hello, ZerJun Eng"
    Then I should see the image "/images/logo/logo_full_2.svg"
    Then I should see the image "/images/logo/logo_text_white.svg"
    Then I should see "MENU DEALS ORDER" within "#desktop_menu"
    When I follow "DEALS" within "#desktop_menu"
    Then I should be on the deals page
    Then I should see "Daily Deals"
    Then I should see the image "/images/deals/deal-1.png"
    Then I should see the image "/images/deals/deal-2.png"
    Then I should see the image "/images/deals/deal-3.png"
    Then I should see the image "/images/logo/logo_text.svg"
    Then I should see "About Us Contact Us Accessibility" within ".footer_nav"
    Then I should not see "Control Panel" within ".footer_nav"
    Then I should see "Group 31, Team Software Project, 2017" within "footer"

  Scenario: User logged in on order page
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
    Then I should see "Your Shopping Basket is Empty, continue shopping on the"
    Then I should not see "You must sign in to place an order"
    Then I should see the image "/images/logo/logo_text.svg"
    Then I should see "About Us Contact Us Accessibility" within ".footer_nav"
    Then I should not see "Control Panel" within ".footer_nav"
    Then I should see "Group 31, Team Software Project, 2017" within "footer"

  Scenario: User logged in on special offers page
    Given I am on the special offers page
    Then I should see "Sign in with Twitter"
    And I want to sign in as user
    When I follow "Sign in with Twitter" within "#desktop_header"
    Then I should see "Hello, ZerJun Eng"
    Then I should see the image "/images/logo/logo_full_2.svg"
    Then I should see the image "/images/logo/logo_text_white.svg"
    Then I should see "MENU DEALS ORDER" within "#desktop_menu"
    When I follow "My Offers" within "#desktop_login_overlay"
    Then I should be on the special offers page
    Then I should see "My Special Offers"
    Then I should see "Code Description"
    Then I should see "PIZZA31 10% Off"
    Then I should see "About Us Contact Us Accessibility" within ".footer_nav"
    Then I should not see "Control Panel" within ".footer_nav"
    Then I should see "Group 31, Team Software Project, 2017" within "footer"

  Scenario: User logged in on about us page
    Given I am on the about us page
    Then I should see "Sign in with Twitter"
    And I want to sign in as user
    When I follow "Sign in with Twitter" within "#desktop_header"
    When I follow "About Us" within ".footer_nav"
    Then I should be on the about us page
    Then I should see "Hello, ZerJun Eng"
    Then I should see the image "/images/logo/logo_full_2.svg"
    Then I should see the image "/images/logo/logo_text_white.svg"
    Then I should see "MENU DEALS ORDER" within "#desktop_menu"
    Then I should see "Who are Pizza31?"
    Then I should see "Yoonji Kim"
    Then I should see "Zer Jun Eng"
    Then I should see "Andreas Ioannou"
    Then I should see "Hin Chak Lau"
    Then I should see "Yujia Cheng"
    Then I should see "Hok Hin Yu"
    Then I should see the image "/images/logo/logo_text.svg"
    Then I should see "About Us Contact Us Accessibility" within ".footer_nav"
    Then I should not see "Control Panel" within ".footer_nav"
    Then I should see "Group 31, Team Software Project, 2017" within "footer"

  Scenario: User logged in on contact us page
    Given I am on the contact us page
    Then I should see "Sign in with Twitter"
    And I want to sign in as user
    When I follow "Sign in with Twitter" within "#desktop_header"
    When I follow "Contact Us" within ".footer_nav"
    Then I should be on the contact us page
    Then I should see "Hello, ZerJun Eng"
    Then I should see the image "/images/logo/logo_full_2.svg"
    Then I should see the image "/images/logo/logo_text_white.svg"
    Then I should see "MENU DEALS ORDER" within "#desktop_menu"
    Then I should see "What Can We Help You With?"
    Then I should see "Tweet"
    When I fill in "comments" with "Feedback" within ".textarea"
    Then I should see the image "/images/logo/logo_text.svg"
    Then I should see "About Us Contact Us Accessibility" within ".footer_nav"
    Then I should not see "Control Panel" within ".footer_nav"
    Then I should see "Group 31, Team Software Project, 2017" within "footer"

  Scenario: User logged in on accessibility page
    Given I am on the accessibility page
    Then I should see "Sign in with Twitter"
    And I want to sign in as user
    When I follow "Sign in with Twitter" within "#desktop_header"
    When I follow "Accessibility" within ".footer_nav"
    Then I should be on the accessibility page
    Then I should see "Hello, ZerJun Eng"
    Then I should see the image "/images/logo/logo_full_2.svg"
    Then I should see the image "/images/logo/logo_text_white.svg"
    Then I should see "MENU DEALS ORDER" within "#desktop_menu"
    Then I should see "Accessibility Statement"
    Then I should see "Our Commitment to Accessibility"
    Then I should see "Having Difficulties?"
    Then I should see the image "/images/logo/logo_text.svg"
    Then I should see "About Us Contact Us Accessibility" within ".footer_nav"
    Then I should not see "Control Panel" within ".footer_nav"
    Then I should see "Group 31, Team Software Project, 2017" within "footer"
    When I follow "Contact Us" within "section"
    Then I should be on the contact us page
    Then I should see "What Can We Help You With?"
