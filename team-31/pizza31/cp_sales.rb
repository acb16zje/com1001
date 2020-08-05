# Back end file for Control Panel
# Sales statistics of each pizza

# Control Panel - Sales
get '/control_panel' do
  if session[:admin].eql? 1
    @overview = 'active'

    erb :'back_end/overview'
  else
    not_found
  end
end

# Control Panel - Sheffield Sales
get '/control_panel/sheffield_sales' do
  if session[:admin].eql? 1
    @sheffield_sales = 'active'

    # Required for displaying pizzas in the table
    @sheffield_count = @menu_db.execute(
      'SELECT pizza_id FROM pizza_location WHERE location IN (?, ?)',
      'Sheffield', 'Both'
    )

    @sheffield_pizza_name = @menu_db.execute(
      'SELECT pizzas.name FROM pizzas JOIN pizza_location
      ON pizza_location.pizza_id = pizzas.pizza_id
      WHERE pizza_location.location IN ("Both", "Sheffield")'
    )

    @sheffield_amount_sold = @menu_db.execute(
      'SELECT amount_sold FROM pizza_sold WHERE location = "Sheffield"'
    ).to_s.delete('[]')

    erb :'back_end/sheffield_sales'
  else
    not_found
  end
end

# Control Panel - London Sales
get '/control_panel/london_sales' do
  if session[:admin].eql? 1
    @london_sales = 'active'

    # Required for displaying pizzas in the table
    @london_count = @menu_db.execute(
      'SELECT pizza_id FROM pizza_location WHERE location IN (?, ?)',
      'London', 'Both'
    )

    @london_pizza_name = @menu_db.execute(
      'SELECT pizzas.name FROM pizzas JOIN pizza_location
      ON pizza_location.pizza_id = pizzas.pizza_id
      WHERE pizza_location.location IN ("Both", "London")'
    )

    @london_amount_sold = @menu_db.execute(
      'SELECT amount_sold FROM pizza_sold WHERE location = "London"'
    ).to_s.delete('[]')

    erb :'back_end/london_sales'
  else
    not_found
  end
end
