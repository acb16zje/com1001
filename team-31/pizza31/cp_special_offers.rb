# Back end file for adding, editing and deleting special offers, promo codes

# Control Panel - Special Offers
get '/control_panel/special_offers' do
  if session[:admin].eql? 1
    @special_offers = 'active'

    # Required for displaying codes in the table
    @offers_count = @special_db.get_first_value('SELECT COUNT(1) FROM codes')

    # Required for adding a special offer
    @unique = session.delete(:unique)

    # Required for dropdown selections
    @offers_ids = @special_db.execute('SELECT code_id FROM codes')

    # Required for editing deal
    @edit_unique = session.delete(:edit_unique)
    @code_id = session[:code_id]
    @offer_selected = session.delete(:offer_selected)

    # Required for displaying alert text
    @add_submit = session.delete(:added)
    @edit_submit = session.delete(:edited)
    @delete_submit = session.delete(:deleted)

    erb :'back_end/special_offers'
  else
    not_found
  end
end

# Add a special offer into the special offers database
post '/control_panel/special_offers/add_offer' do
  session[:added] = true
  @user = ''

  session[:unique] = @special_db.get_first_value(
    'SELECT COUNT(1) FROM codes WHERE code = ?', params[:code].upcase.strip
  ).eql? 0

  # Combine all selected users into one string
  (0...params[:username].length).each do |row|
    if row.eql? (params[:username].length - 1)
      @user += "#{params[:username][row].to_s.delete('[]"')}"
    else
      @user += "#{params[:username][row].to_s.delete('[]"')}, "
    end
  end

  # Add the code to all the selected users
  if session[:unique]
    code_id = @special_db.get_first_value('SELECT MAX(code_id) + 1 FROM codes')
    @special_db.execute(
      'INSERT INTO codes VALUES (?, ?, ?, ?, ?, ?)',
      code_id, params[:code].upcase.strip, params[:description].strip,
      params[:discount].strip, '', @user
    )
  end

  if params[:username][0].eql? 'all'
    @admin_tweet.update(
      "Use the code #{params[:code].upcase.strip} for #{params[:description].strip}! "\
      "The code expires at 11:59AM #{Date.today + 1} (UTC)"
    )
  else
    (0...params[:username].length).each do |username|
      @admin_tweet.update(
        "@#{params[:username][username]} A special offer has been added to your account! "\
        'Go to "My Offer" section to see the details'
      )
    end
  end

  redirect 'control_panel/special_offers'
end

# Get the deal information for editing
get '/control_panel/special_offers/get_offer_edit_info' do
  session[:offer_selected] = true

  session[:code_id] = params[:code_id].to_s.delete('[]').to_i

  redirect 'control_panel/special_offers#redirect'
end

# Update the edited special offer information
post '/control_panel/special_offers/edit_offer' do
  session[:edited] = true

  @input_code = params[:code].upcase.strip

  if @special_db.get_first_value(
    'SELECT COUNT(1) FROM codes WHERE code = ?', params[:code].upcase.strip
  ).eql? 0
    @name_unique = true
  end

  # Check if the same code already exists
  ## An offer code cannot be edited into a same code with another offer
  if @special_db.get_first_value(
    'SELECT code FROM codes WHERE code_id = ?', session[:code_id]
  ).eql? @input_code
    session[:edit_unique] = true
  elsif @name_unique
    session[:edit_unique] = true
  else
    session[:edit_unique] = false;
  end

  # Update the information if it it's unique
  if session[:edit_unique]
    @special_db.execute(
      'UPDATE codes SET code = ? WHERE code_id = ?',
      params[:code].upcase.strip, session[:code_id]
    )

    @special_db.execute(
      'UPDATE codes SET description = ? WHERE code_id = ?',
      params[:description].strip, session[:code_id]
    )

    @special_db.execute(
      'UPDATE codes SET discount = ? WHERE code_id = ?',
      params[:discount].strip, session[:code_id]
    )

    @user = ''

    # Combine all selected users into one string
    (0...params[:username].length).each do |row|
      if row.eql? (params[:username].length - 1)
        @user += "#{params[:username][row].to_s.delete('[]"')}"
      else
        @user += "#{params[:username][row].to_s.delete('[]"')}, "
      end
    end

    @special_db.execute(
      'UPDATE codes SET username = ? WHERE code_id = ?',
      @user, session[:code_id]
    )

  end

  redirect 'control_panel/special_offers'
end

# Delete deal(s) from the deals database
post '/control_panel/deals/delete_offer' do
  session[:deleted] = true

  @code_id = params[:code_id]

  # Delete the special offer form the database
  (0...@code_id.length).each do |row|
    @del = @code_id[row].to_s.delete('[]"').to_i
    @special_db.execute('DELETE FROM codes WHERE code_id = ?', @del)
  end

  # Update the row otherwise errors will occur
  (0...@code_id.length).each do |row|
    @del = @code_id[row].to_s.delete('[]"').to_i
    @special_db.execute(
      'UPDATE codes SET code_id = code_id-1 WHERE code_id > ?', @del
    )
  end

  redirect 'control_panel/special_offers'
end
