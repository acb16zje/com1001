# All the main pages #

# Homepage
['/', '/index'].each do |homepage|
  get homepage do
    @author = 'Yoonji Kim, Yujia Cheng and Zer Jun Eng'
    @title = 'Homepage | Pizza31'
    @css = '/css/index.css'
    @deal_entries = @deals_db.execute('SELECT deal_id FROM deals')
    session[:page] = 'index'
    erb :'front_end/index'
  end
end

# Menu
get '/menu' do
  @author = 'Zer Jun Eng, Lau Hin Chak and Andreas Ioannou'
  @title = 'Menu | Pizza31'
  @css = '/css/menu.css'

  # Display menu based on the user's location
  @sheffield_menu_entries = @menu_db.execute(
    'SELECT pizza_id FROM pizza_location WHERE location IN (?, ?)',
    'Sheffield', 'Both'
  )
  @london_menu_entries = @menu_db.execute(
    'SELECT pizza_id FROM pizza_location WHERE location IN (?, ?)',
    'London', 'Both'
  )
  @location = @accounts_db.get_first_value(
    'SELECT location FROM account_location WHERE username LIKE "%" || ? || "%"',
    session[:username]
  )

  @no_location = (@location.eql? '') || (@location.eql? nil)

  @too_far = (
    !(@location.eql? 'Sheffield, England') &&
    !(@location.eql? 'London, England') &&
    !(@location.eql? '')
  )

  if @no_location
    @disabled = 'disabled'.to_s
  else
    @disabled = ''
  end

  session[:page] = 'menu'
  erb :'front_end/menu'
end

# Adding pizzas to basket
get '/menu/add_to_basket' do
  @item_id = @orders_db.get_first_value('SELECT MAX(item_id) + 1 FROM basket')
  @pizza_id = params[:pizza_id].to_s.delete('[]').to_i
  @pizza_size = params[:pizza_size]
  @quantity = params[:quantity].to_s.delete('[]').to_i

  # Update the quantity if the user adds the same pizza with same size
  if @orders_db.execute(
    'SELECT COUNT(1) FROM basket WHERE pizza_id = ? AND size = ? AND username = ?',
    @pizza_id, @pizza_size, session[:username]
  ).to_s.delete('[]').to_i >= 1
    @orders_db.execute(
      'UPDATE basket SET quantity = quantity+? WHERE pizza_id = ? AND size = ? AND username = ?',
      @quantity, @pizza_id, @pizza_size, session[:username]
    )
  else
    if @item_id.eql? nil
      @orders_db.execute(
        'INSERT INTO basket VALUES (?, ?, ?, ?, ?)', 1,
        @pizza_id, @pizza_size, @quantity, session[:username]
      )
    else
      @orders_db.execute(
        'INSERT INTO basket VALUES (?, ?, ?, ?, ?)',
        @item_id, @pizza_id, @pizza_size, @quantity, session[:username]
      )
    end
  end

  redirect 'menu#redirect'
end

# Deals
get '/deals' do
  @author = 'Yujia Cheng'
  @title = 'Deals & Offers | Pizza31'
  @css = '/css/deals.css'

  @deal_entries = @deals_db.execute('SELECT deal_id FROM deals')

  session[:page] = 'deals'
  erb :'front_end/deals'
end

# Order
get '/order' do
  @author = 'Zer Jun Eng and Andreas Ioannou'
  @title = 'Order | Pizza31'
  @css ="/css/order.css"
  @javascript = '/javascript/orders.js'

  @location = get_account_location(session[:username])

  @no_location = (@location.eql? '') || (@location.eql? nil)

  # Not in Sheffield or London
  @too_far = (
    !(@location.eql? 'Sheffield, England') &&
    !(@location.eql? 'London, England') &&
    !@empty_location
  )

  @offers_id = @special_db.execute(
    'SELECT code_id FROM codes WHERE used NOT LIKE "%" || ? || "%"',
    session[:username]
  )

  @order_placed = session.delete(:order_placed)

  # Empty the basket if user logs out
  if session[:logged_in]
    @basket = session[:total_items]
    @basket_entries = @orders_db.execute('SELECT item_id FROM basket WHERE username = ?', session[:username])
    @total_price = calculate_total_price(@basket_entries)
  else
    @basket = 0
  end

  unless @basket.eql? 0
    @total_price = get_eligible_deal(@total_price)
  end

  session[:page] = 'order'
  erb :'front_end/order'
end

# Update the price if quantity changes
get '/order/update_price' do

  # Update the quantity or delete the item
  if params[:action].eql? 'update'
    # Remove the item if the quantity is changed to 0
    if params[:quantity].to_i.eql? 0
      @orders_db.execute(
        'DELETE FROM basket WHERE item_id = ? AND size = ?',
        params[:item_id].to_i, params[:pizza_size]
      )
      @orders_db.execute(
        'UPDATE basket SET item_id = item_id - 1 WHERE item_id > ?',
        params[:item_id].to_i
      )
    else
      @orders_db.execute(
        'UPDATE basket SET quantity = ? WHERE item_id = ? AND size = ?',
        params[:quantity].strip, params[:item_id].to_i, params[:pizza_size]
      )
    end
  elsif params[:action].eql? 'delete'
    @orders_db.execute(
      'DELETE FROM basket WHERE item_id = ? AND size = ?',
      params[:item_id].to_i, params[:pizza_size]
    )
    @orders_db.execute(
      'UPDATE basket SET item_id = item_id - 1 WHERE item_id > ?',
      params[:item_id].to_i
    )
  end

  redirect 'order#redirect'
end

# About Us
get '/about' do
  @author = 'Yoonji Kim'
  @title = 'About Us | Pizza 31'
  @css = '/css/about_us.css'
  session[:page] = 'about'
  erb :'front_end/about_us'
end

# Contact Us
get '/contact' do
  @author = 'Zer Jun Eng and Andreas Ioannou'
  @title = 'Contact Us | Pizza31'
  @css = '/css/contact_us.css'
  @javascript = '/javascript/contact_us.js'
  @tweeted = session.delete(:tweeted)

  session[:page] = 'contact'
  erb :'front_end/contact_us'
end

# Use the user's Twitter account to send an inquiry tweet on Contact Us page
post '/contact/user_inquiry' do
  session[:tweeted] = true
  USER.update("@pizza_31 #{params[:comments].strip}")

  redirect '/contact'
end

# Accessibility
get '/accessibility' do
  @author = 'Zer Jun Eng and Yoonji Kim'
  @title = 'Accessibility | Pizza31'
  @css = '/css/accessibility.css'
  session[:page] = 'accessibility'
  erb :'front_end/accessibility'
end

# My Profile
get '/profile' do
  @author = 'Yujia Cheng, Zer Jun Eng and Andreas Ioannou'
  @title = 'My Profile | Pizza31'
  @css = '/css/profile.css'
  @javascript = '/javascript/profile.js'

  @email = get_account_email(session[:username])
  @phone = get_account_phone(session[:username])
  @address = get_account_address(session[:username])
  @location = get_account_location(session[:username])
  @postcode = get_account_postcode(session[:username])

  @saved = session.delete(:saved)

  session[:page] = 'profile'
  erb :'front_end/profile'
end

# Order history page, My Orders
get '/order_history' do
  @author = 'Zer Jun Eng'
  @title = 'My Orders | Pizza31'
  @css = '/css/order_history.css'
  @javascript = '/javascript/order_history.js'

  @order_placed = session.delete(:order_placed)

  @order_history = @orders_db.execute(
    'SELECT order_id FROM orders WHERE username LIKE "%" || ? || "%"',
    session[:username]
  )

  session[:page] = 'order_history'
  erb :'front_end/order_history'
end

# My Offers page
get '/special_offers' do
  @author = 'Zer Jun Eng'
  @title = 'My Special Offers | Pizza31'
  @css = '/css/order_history.css'
  @javascript = '/javascript/order_history.js'

  @special_offers = @special_db.execute(
    'SELECT code_id FROM codes WHERE used NOT LIKE "%" || ? || "%"',
    session[:username]
  )

  session[:page] = 'special_offers'
  erb :'front_end/offers'
end
