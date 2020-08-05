# Back end file for handling the orders

# Place an order
post '/order/place_order' do
  order = '@pizza_31 {' + params[:order_type].to_s + '}'
  @basket_entries = @orders_db.execute('SELECT DISTINCT pizza_id FROM basket')

  # Convert the items in the basket into string for tweeting
  @basket_entries.each do |pizza_id|
    order += ' | '
    order += get_pizza_name(pizza_id)
    size = @orders_db.execute(
      'SELECT size FROM basket WHERE pizza_id = ?', pizza_id
    )

    # Shorten the size to first capital letter
    size.each do |sizes|
      order += ', ' + sizes.to_s.delete('[]"')[0] + ':'
      order += @orders_db.execute(
        'SELECT quantity FROM basket WHERE pizza_id = ? AND size = ?',
        pizza_id, sizes
      ).to_s.delete('[]')
    end
  end

  # Pizza customization
  unless params[:customize].to_s.delete('[]"').eql? ''
    order += ' | *' + params[:customize].to_s.delete('[]"')
  end

  # Post the tweet based on the length of the string
  post_order_tweet(order)

  # If a special offer is used, remove it from the user
  unless params[:special_offer].to_s.delete('[]').eql? ''
    @special_db.execute(
      'UPDATE codes SET used = used || ? || ", " WHERE code_id = ?',
      session[:username], params[:special_offer]
    )
  end

  # Move the items into a temporary basket and display a success message
  session[:order_placed] = true
  @orders_db.execute('DELETE FROM basket WHERE username = ?', session[:username])

  redirect '/order'
end

post '/order/buy_again' do
  @new_order_id = @orders_db.get_first_value(
    'SELECT MAX(order_id) + 1 FROM temp_basket'
  )

  @total_item_id = @orders_db.get_first_value(
    'SELECT COUNT(1) FROM temp_basket WHERE order_id = ?',
    params[:order_id]
  )

  for item_id in 1..@total_item_id do
    @orders_db.execute(
      'INSERT INTO temp_basket VALUES (?, ?, ?, ?, ?, ?)',
      @new_order_id,
      item_id,
      @orders_db.get_first_value('SELECT pizza_id FROM temp_basket WHERE item_id = ? AND order_id = ?', item_id, params[:order_id]),
      @orders_db.get_first_value('SELECT size FROM temp_basket WHERE item_id = ? AND order_id = ?', item_id, params[:order_id]),
      @orders_db.get_first_value('SELECT quantity FROM temp_basket WHERE item_id = ? AND order_id = ?', item_id, params[:order_id]),
      @orders_db.get_first_value('SELECT username FROM temp_basket WHERE item_id = ? AND order_id = ?', item_id, params[:order_id])
    )
  end

  post_order_tweet(params[:order_info])

  session[:order_placed] = true
  redirect '/order_history'
end

# Control Panel - Sheffield Orders
get '/control_panel/sheffield_orders' do
  if session[:admin].eql? 1
    @sheffield_orders = 'active'

    # Join the tables
    @pending_order_SHF = @orders_db.execute(
      'SELECT order_location.order_id FROM order_location JOIN order_status
      ON order_location.order_id = order_status.order_id
      WHERE order_location.location = "Sheffield, England"
      AND order_status.order_status = "Pending"'
    )

    @active_order_SHF = @orders_db.execute(
      'SELECT order_location.order_id FROM order_location JOIN order_status
      ON order_location.order_id = order_status.order_id
      WHERE order_location.location = "Sheffield, England"
      AND order_status.order_status = "Active"'
    )

    @completed_order_SHF = @orders_db.execute(
      'SELECT order_location.order_id FROM order_location JOIN order_status
      ON order_location.order_id = order_status.order_id
      WHERE order_location.location = "Sheffield, England"
      AND order_status.order_status = "Completed"'
    )

    @cancelled_order_SHF = @orders_db.execute(
      'SELECT order_location.order_id FROM order_location JOIN order_status
      ON order_location.order_id = order_status.order_id
      WHERE order_location.location = "Sheffield, England"
      AND order_status.order_status = "Cancelled"'
    )

    erb :'back_end/sheffield_orders'
  else
    not_found
  end
end

# Control Panel - London Orders
get '/control_panel/london_orders' do
  if session[:admin].eql? 1
    @london_orders = 'active'

    # Join the tables
    @pending_order_LON = @orders_db.execute(
      'SELECT order_location.order_id FROM order_location JOIN order_status
      ON order_location.order_id = order_status.order_id
      WHERE order_location.location = "London, England"
      AND order_status.order_status = "Pending"'
    )

    @active_order_LON = @orders_db.execute(
      'SELECT order_location.order_id FROM order_location JOIN order_status
      ON order_location.order_id = order_status.order_id
      WHERE order_location.location = "London, England"
      AND order_status.order_status = "Active"'
    )

    @completed_order_LON = @orders_db.execute(
      'SELECT order_location.order_id FROM order_location JOIN order_status
      ON order_location.order_id = order_status.order_id
      WHERE order_location.location = "London, England"
      AND order_status.order_status = "Completed"'
    )

    @cancelled_order_LON = @orders_db.execute(
      'SELECT order_location.order_id FROM order_location JOIN order_status
      ON order_location.order_id = order_status.order_id
      WHERE order_location.location = "London, England"
      AND order_status.order_status = "Cancelled"'
    )

    erb :'back_end/london_orders'
  else
    not_found
  end
end

# Move pending order to active state, or cancel it
post '/control_panel/orders/move_to_active' do
  if params[:action].eql? 'active'
    change_order_status('Active', params[:order_id])

    # Tweet back to the user saying that the order is now confirmed
    @admin_tweet.update(
      "@#{get_order_username(params[:order_id])} Your order is now confirmed!"
    )

    # Update the sales statistics when an order is confirmed
    case params[:location]
      when 'Sheffield'
        update_pizza_amount_sold('Sheffield', params[:order_id])
        update_order_day_amount(params[:day], 'Sheffield')
        update_revenue('Sheffield', params[:total_price])
      when 'London'
        update_pizza_amount_sold('London', params[:order_id])
        update_order_day_amount(params[:day], 'London')
        update_revenue('London', params[:total_price])
    end
  elsif params[:action].eql? 'cancel'
    change_order_status('Cancelled', params[:order_id])
  end

  case params[:location]
    when 'Sheffield'
      redirect 'control_panel/sheffield_orders'
    when 'London'
      redirect 'control_panel/london_orders'
  end
end

# Move active order to completed state
post '/control_panel/orders/move_to_completed' do
  change_order_status('Completed', params[:order_id])

  # Tweet back to the user saying that the order is now confirmed
  @admin_tweet.update(
    "@#{get_order_username(params[:order_id])} Your order is now dispatched! We hope you enjoyed our services"
  )

  case params[:location]
    when 'Sheffield'
      redirect 'control_panel/sheffield_orders'
    when 'London'
      redirect 'control_panel/london_orders'
  end
end
