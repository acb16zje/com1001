# Methods file used to retrive pizza's info from menu.sqlite

def get_pizza_name(id)
  @menu_db.get_first_value(
    'SELECT name FROM pizzas WHERE pizza_id = ?', id
  ).to_s.delete('[]"')
end

def get_pizza_category(id)
  category = @menu_db.get_first_value(
    'SELECT price_category FROM pizza_pricing WHERE pizza_id = ?', id
  ).to_s.delete('[]"').to_i

  if category.eql? 1
    return 'Regular'
  else
    return 'Special'
  end
end

def get_pizza_description(id)
  @menu_db.get_first_value(
    'SELECT description FROM pizzas WHERE pizza_id = ?', id
  ).to_s.delete('[]"')
end

def get_pizza_allergen_info(id)
  @menu_db.get_first_value(
    'SELECT allergen_info FROM pizzas WHERE pizza_id = ?', id
  ).to_s.delete('[]"')
end

def get_pizza_location(id)
  @menu_db.get_first_value(
    'SELECT location FROM pizza_location WHERE pizza_id = ?', id
  ).to_s.delete('[]"')
end

def get_pizza_image_path(id)
  @menu_db.get_first_value(
    'SELECT image_path FROM pizzas WHERE pizza_id = ?', id
  ).to_s.delete('[]"')
end

def get_small_pizza_price(category)
  @menu_db.get_first_value(
    'SELECT price FROM pricing WHERE size LIKE "Small" AND price_category = ?',
    category
  ).to_s.delete('[]"')
end

def get_medium_pizza_price(category)
  @menu_db.get_first_value(
    'SELECT price FROM pricing WHERE size LIKE "Medium" AND price_category = ?',
    category
  ).to_s.delete('[]"')
end

def get_large_pizza_price(category)
  @menu_db.get_first_value(
    'SELECT price FROM pricing WHERE size LIKE "Large" AND price_category = ?',
    category
  ).to_s.delete('[]"')
end

def get_pizza_amount_sold_sheffield(id)
  @menu_db.get_first_value(
    'SELECT amount_sold FROM pizza_sold WHERE pizza_id = ? AND location = "Sheffield"', id
  ).to_s.delete('[]"')
end

def get_pizza_amount_sold_london(id)
  @menu_db.get_first_value(
    'SELECT amount_sold FROM pizza_sold WHERE pizza_id = ? AND location = "London"', id
  ).to_s.delete('[]"')
end

def update_pizza_amount_sold(location, id)
  pizza_id = @orders_db.execute(
    'SELECT pizza_id FROM temp_basket WHERE order_id = ?', id
  )

  # Update the quantity
  pizza_id.each do |pizza|
    quantity = @orders_db.get_first_value(
      'SELECT quantity FROM temp_basket WHERE pizza_id = ?', pizza
    ).to_s.delete('[]').to_i

    @menu_db.execute(
      'UPDATE pizza_sold SET amount_sold = amount_sold+? WHERE pizza_id = ? AND location = ?',
      quantity, pizza, location
    )
  end
end

def update_revenue(location, price)
  @menu_db.execute(
    'UPDATE revenue SET revenue = revenue + ? WHERE location = ?',
    price, location
  )
end
