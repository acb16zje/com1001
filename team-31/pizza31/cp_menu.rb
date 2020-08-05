# Back end file for adding, editing and deleting the pizzas

# Control Panel - Menu
get '/control_panel/menu' do
  if session[:admin].eql? 1
    @menu = 'active'

    # Required for displaying pizzas in the table
    @int_count = @menu_db.get_first_value('SELECT COUNT(1) FROM pizzas')

    # Required for adding pizza
    @unique = session.delete(:unique)

    # Required for editing pizza
    @edit_unique = session.delete(:edit_unique)
    @pizza_id = session[:pizza_id]
    @pizza_selected = session.delete(:pizza_selected)

    # Required for dropdown selections
    @pizza_ids = @menu_db.execute('SELECT pizza_id FROM pizzas')

    # Required for category pricing
    @category_id = session[:category_id]
    @category_selected = session.delete(:category_selected)

    # Required for displaying alert text
    @add_submit = session.delete(:added)
    @edit_submit = session.delete(:edited)
    @delete_submit = session.delete(:deleted)
    @pricing_change = session.delete(:pricing_changed)

    erb :'back_end/menu'
  else
    not_found
  end
end

# Add a pizza into the menu database
post '/control_panel/menu/add_pizza' do
  session[:added] = true

  case params[:location]
    when 'Sheffield'
      @path = "/images/pizza/sheffield/#{params[:image_path].strip}"
    when 'London'
      @path = "/images/pizza/london/#{params[:image_path].strip}"
    when 'Both'
      @path = "/images/pizza/#{params[:image_path].strip}"
  end

  session[:unique] = @menu_db.get_first_value(
    'SELECT COUNT(1) FROM pizzas WHERE name = ?', params[:name].strip
  ).eql? 0

  # Check if the same pizza name already exists
  if session[:unique]
    pizza_id = @menu_db.get_first_value('SELECT MAX(pizza_id) + 1 FROM pizzas')
    @menu_db.execute(
      'INSERT INTO pizzas VALUES (?, ?, ?, ?, ?)',
      pizza_id, params[:name].strip, params[:description].strip,
      params[:allergen_info].strip, @path
    )
    @menu_db.execute(
      'INSERT INTO pizza_location VALUES (?, ?)',
      pizza_id, params[:location]
    )
    @menu_db.execute(
      'INSERT INTO pizza_pricing VALUES(?, ?)',
      pizza_id, params[:category]
    )
  end

  redirect 'control_panel/menu'
end

# Get the pizza information for editing
get '/control_panel/menu/get_edit_info' do
  session[:pizza_selected] = true

  session[:pizza_id] = params[:pizza_id].to_s.delete('[]').to_i

  redirect 'control_panel/menu#redirect'
end

# Update the edited pizza information
post '/control_panel/menu/edit_pizza' do
  session[:edited] = true

  case params[:location]
    when 'Sheffield'
      @path = "/images/pizza/sheffield/#{params[:image_path].strip}"
    when 'London'
      @path = "/images/pizza/london/#{params[:image_path].strip}"
    when 'Both'
      @path = "/images/pizza/#{params[:image_path].strip}"
  end

  @input_name = params[:name].strip

  if @menu_db.get_first_value(
    'SELECT COUNT(1) FROM pizzas WHERE name = ?', params[:name].strip
  ).eql? 0
    @name_unique = true
  end

  # Check if the same pizza name already exists
  ## A pizza name cannot be edited into a same name with another pizza
  if @menu_db.get_first_value(
    'SELECT name FROM pizzas WHERE pizza_id = ?', session[:pizza_id]
  ).eql? @input_name
    session[:edit_unique] = true
  elsif @name_unique
    session[:edit_unique] = true
  else
    session[:edit_unique] = false
  end

  # Update the information if it it's unique
  if session[:edit_unique]
    @menu_db.execute(
      'UPDATE pizzas SET name = ? WHERE pizza_id = ?',
      params[:name].strip, session[:pizza_id]
    )

    @menu_db.execute(
      'UPDATE pizzas SET description = ? WHERE pizza_id = ?',
      params[:description].strip, session[:pizza_id]
    )

    @menu_db.execute(
      'UPDATE pizzas SET allergen_info = ? WHERE pizza_id = ?',
      params[:allergen_info].strip, session[:pizza_id]
    )

    @menu_db.execute(
      'UPDATE pizza_location SET location = ? WHERE pizza_id = ?',
      params[:location], session[:pizza_id]
    )

    @menu_db.execute(
      'UPDATE pizza_pricing SET price_category = ? WHERE pizza_id = ?',
      params[:category].to_i, session[:pizza_id]
    )

    unless params[:image_path].eql? ''
      @menu_db.execute(
        'UPDATE pizzas SET image_path = ? WHERE pizza_id = ?',
        @path, session[:pizza_id]
      )
    end
  end

  redirect 'control_panel/menu'
end

# Delete pizza(s) from the menu database
post '/control_panel/menu/delete_pizza' do
  session[:deleted] = true

  @pizza_id = params[:pizza_id]

  # Delete the pizza form the database
  (0...@pizza_id.length).each do |row|
    @del = @pizza_id[row].to_s.delete('[]"').to_i
    @menu_db.execute('DELETE FROM pizzas WHERE pizza_id = ?', @del)
    @menu_db.execute('DELETE FROM pizza_location WHERE pizza_id = ?', @del)
    @menu_db.execute('DELETE FROM pizza_pricing WHERE pizza_id = ?', @del)
  end

  # Update the row otherwise errors will occur
  (0...@pizza_id.length).each do |row|
    @del = @pizza_id[row].to_s.delete('[]"').to_i
    @menu_db.execute(
      'UPDATE pizzas SET pizza_id = pizza_id-1 WHERE pizza_id > ?', @del
    )
    @menu_db.execute(
      'UPDATE pizza_location SET pizza_id = pizza_id-1 WHERE pizza_id > ?', @del
    )
    @menu_db.execute(
      'UPDATE pizza_pricing SET pizza_id = pizza_id-1 WHERE pizza_id > ?', @del
    )
  end

  redirect 'control_panel/menu'
end

# Get the price of the selected pricing category
get '/control_panel/menu/get_pricing' do
  session[:category_selected] = true

  session[:category_id] = params[:category_id].to_i

  redirect 'control_panel/menu#redirect'
end

# Update the pricing
post '/control_panel/menu/edit_pricing' do
  session[:pricing_changed] = true

  @menu_db.execute(
    'UPDATE pricing SET price = ? WHERE size = "Small" AND price_category = ?',
    params[:small_price], session[:category_id]
  )
  @menu_db.execute(
    'UPDATE pricing SET price = ? WHERE size = "Medium" AND price_category = ?',
    params[:medium_price], session[:category_id]
  )
  @menu_db.execute(
    'UPDATE pricing SET price = ? WHERE size = "Large" AND price_category = ?',
    params[:large_price], session[:category_id]
  )

  redirect 'control_panel/menu'
end
