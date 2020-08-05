# Back end file for logging in, logging out and update profie

# Redirect to Twitter login page
get '/login' do
  redirect '/auth/twitter'
end

# Redirect to menu or profile page after logging in using OmniAuth
get '/auth/twitter/callback' do
  # Required for displaying information retrived from Twitter
  session[:logged_in] = true
  session[:name] = request.env['omniauth.auth']['info']['name']
  session[:username] = request.env['omniauth.auth']['info']['nickname']
  session[:phone] = request.env['omniauth.auth']['info']['phone']
  session[:location] = request.env['omniauth.auth']['info']['location']
  session[:token] = request.env['omniauth.auth']['credentials']['token']
  session[:secret] = request.env['omniauth.auth']['credentials']['secret']

  # Retrieve data from the account database to check if it's a registered user
  username = @accounts_db.get_first_value(
    'SELECT username FROM accounts WHERE username LIKE "%" || ? || "%"',
    session[:username]
  )

  phone = get_account_phone(session[:username])

  session[:admin] = @accounts_db.get_first_value(
    'SELECT status_id FROM account_status WHERE username LIKE "%" || ? || "%"',
    session[:username]
  )

  # Configure the Twitter client using current Twitter account
  config = {
    :consumer_key => 'ebNTf95exF6GWaIH6SVSCAFNY',
    :consumer_secret => 'lC6It60YFT5WUk2aQ1M78QhdVmu5e2W57cFO4RjluREIVUsJ5l',
    :access_token => "#{session[:token]}",
    :access_token_secret => "#{session[:secret]}"
  }

  USER ||= Twitter::REST::Client.new(config)

  # Never signed in before
  if username.nil?

    # Only make our admin account as admin
    if session[:username].eql? 'pizza_31'
      make_default_admin
    else
      make_regular_customer
    end

    # Insert empty values of new account into the database
    @accounts_db.execute(
      'INSERT INTO accounts VALUES (?, ?)', session[:username], session[:name]
    )
    @accounts_db.execute(
      'INSERT INTO account_phone VALUES (?, ?)', session[:username], ''
    )
    @accounts_db.execute(
      'INSERT INTO account_address VALUES (?, ?)', session[:username], ''
    )
    @accounts_db.execute(
      'INSERT INTO account_email VALUES (?, ?)', session[:username], ''
    )
    @accounts_db.execute(
      'INSERT INTO account_postcode VALUES (?, ?)', session[:username], ''
    )

    # Check if location is provided on the current Twitter account
    if session[:location].eql? ''
      @accounts_db.execute(
        'INSERT INTO account_location VALUES (?, ?)', session[:username], ''
      )
    else
      @accounts_db.execute(
        'INSERT INTO account_location VALUES (?, ?)',
        session[:username], session[:location]
      )
    end

    # Check if it's an admin account
    session[:admin] = @accounts_db.get_first_value(
      'SELECT status_id FROM account_status WHERE username LIKE "%" || ? || "%"',
      session[:username]
    )

    redirect '/profile'

    # Signed in before but didn't provide required information
  elsif (username.eql? session[:username]) && (phone.eql? '')
    @accounts_db.execute(
      'UPDATE account_location SET location = ? WHERE username = ?',
      session[:location], session[:username]
    )

    session[:profile_completed] = false
    redirect '/profile'
  else
    session[:profile_completed] = true
    redirect "#{session[:page]}"
  end
end

# Redirect to homepage after logout
get '/logout' do
  current_page = session[:page]
  if !session[:logged_in].eql? nil
    # Clean all session
    session.clear
    session[:logged_in] = nil

    if current_page.eql? 'profile'
      redirect '/index'
    else
      redirect current_page
    end
  else
    not_found
  end
end

# Save the user's provided information
post '/update_profile' do
  # If the current Twitter account doesn't have location set,
  # update the account location based on selected value
  if session[:location].eql? ''
    @accounts_db.execute(
      'UPDATE account_location SET location = ? WHERE username = ?',
      params[:location], session[:username]
    )
  end

  pc = UKPostcode.parse(params[:postcode].to_s)
  @valid_postcode = false
  if (pc.valid?)
    @valid_postcode = true
  end

  @accounts_db.execute(
    'UPDATE account_email SET email = ? WHERE username = ?',
    params[:email].strip, session[:username]
  )
  @accounts_db.execute(
    'UPDATE account_phone SET phone = ? WHERE username = ?',
    params[:phone].strip, session[:username]
  )
  @accounts_db.execute(
    'UPDATE account_address SET address = ? WHERE username = ?',
    params[:address].strip, session[:username]
  )
  if @valid_postcode
    @accounts_db.execute(
      'UPDATE account_postcode SET postcode = ? WHERE username =?',
      params[:postcode].strip.upcase, session[:username]
    )
    session[:profile_completed] = true
  else
    @accounts_db.execute(
      'UPDATE account_postcode SET postcode = ? WHERE username =?',
      '', session[:username]
    )
    session[:profile_completed] = false
  end

  session[:saved] = true

  redirect '/profile'
end
