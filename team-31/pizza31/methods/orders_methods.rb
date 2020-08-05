# Method to be used in control panel (orders)
def get_order_username(id)
  @orders_db.get_first_value(
    'SELECT username FROM orders WHERE order_id = ?', id
  )
end

def get_order_type(id)
  @orders_db.get_first_value(
    'SELECT order_type FROM order_type WHERE order_id = ?', id
  )
end

def get_order_info(id)
  @orders_db.get_first_value(
    'SELECT order_info FROM orders WHERE order_id = ?', id
  )
end

def get_order_date(id)
  @orders_db.get_first_value(
    'SELECT order_date FROM orders WHERE order_id = ?', id
  )
end

def get_order_tweet_id(id)
  @orders_db.get_first_value(
    'SELECT order_tweet_id FROM orders WHERE order_id = ?', id
  )
end

def get_order_price(id)
  @orders_db.get_first_value(
    'SELECT total_price FROM orders WHERE order_id = ?', id
  ).to_f
end

def get_order_status(id)
  @orders_db.get_first_value(
    'SELECT order_status FROM order_status WHERE order_id = ?', id
  )
end

def change_order_status(status, id)
  @orders_db.execute(
    'UPDATE order_status SET order_status = ? WHERE order_id = ?', status, id
  )
end

def update_order_day_amount(day, location)
  @orders_db.execute(
    'UPDATE order_day_amount SET amount = amount + 1 WHERE day_name LIKE ? AND location LIKE ?',
    day, location
  )
end

# Calculate the total price of the order in the basket
def calculate_total_price(basket)
  total_price = 0
  quantity_price = 0

  basket.each do |id|
    pizza_id = @orders_db.get_first_value(
      'SELECT pizza_id FROM basket WHERE item_id = ? AND username = ?',
      id, session[:username]
    )

    case @orders_db.get_first_value(
      'SELECT size FROM basket WHERE item_id = ? AND username = ?',
      id, session[:username]
    ).to_s.delete('[]"')
      when "Small"
        price = get_small_pizza_price(
          @menu_db.get_first_value(
            'SELECT price_category FROM pizza_pricing WHERE pizza_id = ?',
            pizza_id
          )
        )
      when "Medium"
        price = get_medium_pizza_price(
          @menu_db.get_first_value(
            'SELECT price_category FROM pizza_pricing WHERE pizza_id = ?',
            pizza_id
          )
        )
      when "Large"
        price = get_large_pizza_price(
          @menu_db.get_first_value(
            'SELECT price_category FROM pizza_pricing WHERE pizza_id = ?',
            pizza_id
          )
        )
    end

    quantity_price = @orders_db.execute(
      'SELECT quantity FROM basket WHERE item_id = ? AND username = ?',
      id, session[:username]
    ).to_s.delete('[]"').to_i * price.to_f

    total_price += quantity_price
  end

  return total_price.to_f
end

# Calculate the total price from temporary basket - For buy again in history
def calculate_total_price_from_temp(order_id)
  total_price = 0
  quantity_price = 0

  temp_basket = @orders_db.execute(
    'SELECT item_id FROM temp_basket WHERE order_id = ?', order_id.to_s.delete('[]"').to_i
  )

  temp_basket.each do |id|
    pizza_id = @orders_db.get_first_value(
      'SELECT pizza_id FROM temp_basket WHERE item_id = ? AND username = ?',
      id, session[:username]
    )

    case @orders_db.get_first_value(
      'SELECT size FROM temp_basket WHERE item_id = ? AND username = ?',
      id, session[:username]
    ).to_s.delete('[]"')
      when 'Small'
        price = get_small_pizza_price(
          @menu_db.get_first_value(
            'SELECT price_category FROM pizza_pricing WHERE pizza_id = ?',
            pizza_id
          )
        )
      when 'Medium'
        price = get_medium_pizza_price(
          @menu_db.get_first_value(
            'SELECT price_category FROM pizza_pricing WHERE pizza_id = ?',
            pizza_id
          )
        )
      when 'Large'
        price = get_large_pizza_price(
          @menu_db.get_first_value(
            'SELECT price_category FROM pizza_pricing WHERE pizza_id = ?',
            pizza_id
          )
        )
    end

    quantity_price = @orders_db.get_first_value(
      'SELECT quantity FROM temp_basket WHERE item_id = ? AND username = ?',
      id, session[:username]
    ).to_s.delete('[]"').to_i * price.to_f

    total_price += quantity_price
  end

  total_price = get_rebuy_eligible_deal(order_id, total_price)

  return total_price.round(2)
end

def get_eligible_deal(total_price)
  # Deal 1 - Go Large
  # Two large pizzas, third one free
  @large_pizza = @orders_db.execute(
    'SELECT pizza_id FROM basket WHERE size = "Large"'
  )

  @total_large_pizza = 0

  @large_pizza.each do |pizza|
    @total_large_pizza += @orders_db.get_first_value(
      'SELECT quantity FROM basket WHERE pizza_id = ?', pizza
    ).to_s.delete('[]').to_i
  end

  @deals_discounted_pizza = @orders_db.get_first_value(
    'SELECT MAX(pizza_id) FROM basket WHERE size = "Large"'
  )

  @total_discounted_amount = @total_large_pizza / 3

  @deals_discounted_price = get_large_pizza_price(
    @menu_db.execute(
      'SELECT price_category FROM pizza_pricing WHERE pizza_id = ?', @deals_discounted_pizza
    )
  )

  if @total_large_pizza >= 3
    @deal1_eligible = true
    total_price = (total_price - (@deals_discounted_price.to_f * @total_discounted_amount))
  end

  # Deal 2 - Over 40?
  # 15% off when the total price is over 40
  if total_price > 40
    @deal2_eligible = true
    total_price *= 0.85
  else
    @deal2_eligible = false
  end

  # Deal 3 - Pepsi Lover
  # Every two medium pizzas, get a free Pepsi
  @medium_pizza = @orders_db.execute(
    'SELECT pizza_id FROM basket WHERE size = "Medium"'
  )

  @total_medium_pizza = 0

  @medium_pizza.each do |id|
    @total_medium_pizza += @orders_db.get_first_value(
      'SELECT quantity FROM basket WHERE pizza_id = ? AND size = "Medium"', id
    ).to_s.delete('[]').to_i
  end

  if @total_medium_pizza >= 2
    @deal3_eligible = true
  else
    @deal3_eligible = false
  end

  # Loyalty deal - 5% off
  @status = @accounts_db.get_first_value(
    'SELECT status_id FROM account_status WHERE username = ?',
    session[:username]
  )

  if @status.eql? 2
    @loyal = true
    total_price *= 0.95
  else
    @loyal = false
  end

  return total_price.round(2)
end

def get_rebuy_eligible_deal(order_id, total_price)
  # Deal 1 - Go Large
  # Two large pizzas, third one free
  large_pizza = @orders_db.execute(
    'SELECT pizza_id FROM temp_basket WHERE size = "Large" AND order_id = ?',
    order_id
  )

  total_large_pizza = 0

  large_pizza.each do |pizza|
    total_large_pizza += @orders_db.execute(
      'SELECT quantity FROM temp_basket WHERE pizza_id = ? AND order_id = ?',
      pizza, order_id
    ).to_s.delete('[]').to_i
  end

  deals_discounted_pizza = @orders_db.get_first_value(
    'SELECT MAX(pizza_id) FROM temp_basket WHERE size = "Large" AND order_id = ?',
    order_id
  )

  total_discounted_amount = total_large_pizza / 3

  deals_discounted_price = get_large_pizza_price(
    @menu_db.get_first_value(
      'SELECT price_category FROM pizza_pricing WHERE pizza_id = ?',
      deals_discounted_pizza
    )
  )

  if total_large_pizza >= 3
    total_price = (total_price - (deals_discounted_price.to_f * total_discounted_amount))
  end

  # Deal 2 - Over 40?
  # 15% off when the total price is over 40
  if total_price > 40
    total_price *= 0.85
  end

  # Deal 3 - Pepsi Lover
  # Every two medium pizzas, get a free Pepsi
  medium_pizza = @orders_db.execute(
    'SELECT pizza_id FROM temp_basket WHERE size = "Medium" AND order_id = ?',
    order_id
  )

  total_medium_pizza = 0

  medium_pizza.each do |id|
    total_medium_pizza += @orders_db.get_first_value(
      'SELECT quantity FROM temp_basket WHERE pizza_id = ? AND size = "Medium" AND order_id = ?',
      id, order_id
    ).to_s.delete('[]').to_i
  end

  # Loyalty deal - 5% off
  status = @accounts_db.get_first_value(
    'SELECT status_id FROM account_status WHERE username = ?',
    session[:username]
  )

  if status.eql? 2
    total_price *= 0.95
  end

  return total_price.to_f
end

# Post the order tweet
def post_order_tweet(order)
  # Add order ID
  @order_id = @orders_db.get_first_value(
    'SELECT MAX(order_id) + 1 FROM orders'
  )

  @order_id = 1 if @order_id.eql? nil

  # For storing into order history
  full_order = ''
  full_order += order + ' | #order' + @order_id.to_s

  # Change the tweet format if the order is too long
  if order.length <= 130
    order += ' | #order' + @order_id.to_s
    USER.update(order)

    tweet_date = ''
    first_tweet_id = 0

    mention_tweets = @admin_tweet.mentions_timeline
    mention_tweets.take(1).each do |tweets|
      if tweets.text.include? ('#order' + @order_id.to_s)
        first_tweet_id = tweets.id.to_i
        tweet_date = tweets.created_at.to_s
      end
    end
  else
    # Prevent the tweets to be longer than 140 characters
    # Split the orders into part
    order_split = order.split('|')
    tweet = ''
    first_tweet_id = 0
    first_tweet = true
    first_fetch_id = true

    order_split.each do |item|
      if (item.length + tweet.length) >= 126
        tweet += ' (cont) #order' + @order_id.to_s

        # The tweet will be in reply form it the order is too long
        if first_tweet
          USER.update(tweet)
        else
          mention_tweets = @admin_tweet.mentions_timeline
          mention_tweets.take(1).each do |tweets|
            if tweets.text.include? ('#order' + @order_id.to_s)
              first_tweet_id = tweets.id.to_i if first_fetch_id
              first_fetch_id = false
              USER.update(tweet, :in_reply_to_status_id => first_tweet_id)
            end
          end
        end

        first_tweet = false
        tweet = ''
      end

      tweet += item + '|'
    end

    # Have to refetch the tweets to post reply to the main tweet
    mention_tweets = @admin_tweet.mentions_timeline
    mention_tweets.take(1).each do |tweets|
      if (tweets.text.include? ('#order' + @order_id.to_s)) && (tweets.text.include? ('@pizza_31'))
        first_tweet_id = tweets.id.to_i
        tweet_date = tweets.created_at.to_s
        USER.update(
          tweet + ' #order' + @order_id.to_s,
          :in_reply_to_status_id => first_tweet_id
        )
      end
    end
  end

  total_price = params[:total_price].to_f

  # Apply the special offer
  unless params[:special_offer].to_s.delete('[]').eql? ''
    total_price *= get_special_offer_discount(params[:special_offer])
  end

  # Save the data of the tweet into the database
  @orders_db.execute('INSERT INTO orders VALUES(?, ?, ?, ?, ?, ?)',
                     @order_id, session[:username], full_order, tweet_date[0..9],
                     first_tweet_id, total_price.round(2)
  )

  @orders_db.execute('INSERT INTO order_type VALUES(?, ?)',
                     @order_id, params[:order_type])

  @orders_db.execute('INSERT INTO order_location VALUES(?, ?)',
                     @order_id, get_account_location(session[:username]))

  @orders_db.execute('INSERT INTO order_status VALUES(?, ?)',
                     @order_id, 'Pending')

  no_of_orders = @orders_db.get_first_value(
    'SELECT COUNT(order_id) FROM orders WHERE username LIKE "%" || ? || "%"',
    session[:username]
  ).to_s.delete('[]').to_i

  if no_of_orders >= 3
    make_loyal_customer
    @admin_tweet.follow(session[:username].to_s)
    @admin_tweet.update(
      "@#{session[:username]} Congrats! You are now one of our loyal customers. "\
      'From now on you get 5% on your final price!'
    )
  end

  # Insert into temporary basket
  @basket_list = @orders_db.execute('SELECT item_id FROM basket')
  @basket_list.each do |item_id|
    @orders_db.execute('INSERT INTO temp_basket VALUES(?, ?, ?, ?, ?, ?)',
      @order_id, item_id,
      @orders_db.execute('SELECT pizza_id FROM basket WHERE item_id = ?', item_id),
      @orders_db.execute('SELECT size FROM basket WHERE item_id = ?', item_id),
      @orders_db.execute('SELECT quantity FROM basket WHERE item_id = ?', item_id),
      @orders_db.execute('SELECT username FROM basket WHERE item_id = ?', item_id)
    )
  end
end
