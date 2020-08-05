require 'minitest/autorun'
require 'sqlite3'
require_relative '../pizza31/methods/pizza_methods'

class TestApp < MiniTest::Test
  def test_names
    @menu_db = SQLite3::Database.open '../databases/pizzas.sqlite'
    pepperoni_id = 1
    new_yorker_id = 2
    margherita_id = 3
    mighty_meaty_id = 4
    texasbbq_id = 5
    ham_pineapple_id = 6

    assert_equal 'Pepperoni', get_pizza_name(pepperoni_id)
    assert_equal 'New Yorker', get_pizza_name(new_yorker_id)
    assert_equal 'Margherita', get_pizza_name(margherita_id)
    assert_equal 'Mighty Meaty', get_pizza_name(mighty_meaty_id)
    assert_equal 'Texas BBQ', get_pizza_name(texasbbq_id)
    assert_equal 'Ham & Pineapple', get_pizza_name(ham_pineapple_id)
  end

  def test_descriptions
    @menu_db = SQLite3::Database.open '../databases/pizzas.sqlite'
    pepperoni_id = 1
    new_yorker_id = 2
    margherita_id = 3
    mighty_meaty_id = 4
    texasbbq_id = 5
    ham_pineapple_id = 6

    assert_equal 'Regular base with pepperoni topping', get_pizza_description(pepperoni_id)
    assert_equal 'Pepperoni, ham, bacon, mushrooms', get_pizza_description(new_yorker_id)
    assert_equal 'Regular base with tomato and extra cheese', get_pizza_description(margherita_id)
    assert_equal 'Tomato sauce, pepperoni, ham, ground beef, sausage, red onions, mushrooms and mozzarella cheese', get_pizza_description(mighty_meaty_id)
    assert_equal 'BBQ sauce topped with smoky bacon, succulent roast chicken, red onions, green and red peppers', get_pizza_description(texasbbq_id)
    assert_equal 'Regular base with ham and pineapple toppings', get_pizza_description(ham_pineapple_id)
  end

  def test_allergen_info
    @menu_db = SQLite3::Database.open '../databases/pizzas.sqlite'
    pepperoni_id = 1
    new_yorker_id = 2
    margherita_id = 3
    mighty_meaty_id = 4
    texasbbq_id = 5
    ham_pineapple_id = 6

    assert_equal 'Gluten, milk', get_pizza_allergen_info(pepperoni_id)
    assert_equal 'Gluten, milk', get_pizza_allergen_info(new_yorker_id)
    assert_equal 'Gluten, milk', get_pizza_allergen_info(margherita_id)
    assert_equal 'Gluten, milk, celery and mustard', get_pizza_allergen_info(mighty_meaty_id)
    assert_equal 'Gluten, milk, sulphur dioxide', get_pizza_allergen_info(texasbbq_id)
    assert_equal 'Gluten, milk', get_pizza_allergen_info(ham_pineapple_id)
  end

  def test_location
    @menu_db = SQLite3::Database.open '../databases/pizzas.sqlite'
    pepperoni_id = 1
    new_yorker_id = 2
    margherita_id = 3
    mighty_meaty_id = 4
    texasbbq_id = 5
    ham_pineapple_id = 6

    assert_equal 'Both', get_pizza_location(pepperoni_id)
    assert_equal 'Both', get_pizza_location(new_yorker_id)
    assert_equal 'Both', get_pizza_location(margherita_id)
    assert_equal 'Sheffield', get_pizza_location(mighty_meaty_id)
    assert_equal 'London', get_pizza_location(texasbbq_id)
    assert_equal 'Both', get_pizza_location(ham_pineapple_id)
  end
end
