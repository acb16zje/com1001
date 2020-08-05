# Back end file for adding, editing and deleting the deals

# Control Panel - Deals
get '/control_panel/deals' do
  if session[:admin].eql? 1
    @deals = 'active'

    # Required for displaying deals in the table
    @int_number = @deals_db.get_first_value('SELECT COUNT(1) FROM deals')

    # Required for adding a deal
    @unique = session.delete(:unique)

    # Required for editing deal
    @edit_unique = session.delete(:edit_unique)
    @deal_id = session[:deal_id]
    @deal_selected = session.delete(:deal_selected)

    # Required for dropdown selections
    @deals_ids = @deals_db.execute('SELECT deal_id FROM deals')

    # Required for displaying alert text
    @add_submit = session.delete(:added)
    @edit_submit = session.delete(:edited)
    @delete_submit = session.delete(:deleted)

    erb :'back_end/deals'
  else
    not_found
  end
end

# Add a deal into the deals database
post '/control_panel/deals/add_deal' do
  session[:added] = true

  @path = "/images/deals/#{params[:image_path]}"

  session[:unique] = @deals_db.get_first_value(
    'SELECT COUNT(1) FROM deals WHERE name = ?', params[:name].strip
  ).eql? 0

  # Check if the same deal name already exists
  if session[:unique]
    deal_id = @deals_db.get_first_value('SELECT MAX(deal_id) + 1 FROM deals')
    @deals_db.execute(
      'INSERT INTO deals VALUES (?, ?, ?, ?, ?)',
      deal_id, params[:name].strip, params[:description].strip,
      params[:discount].strip, @path
    )
  end

  redirect 'control_panel/deals'
end

# Get the deal information for editing
get '/control_panel/deals/get_deal_edit_info' do
  session[:deal_selected] = true

  session[:deal_id] = params[:deal_id].to_s.delete('[]').to_i

  redirect 'control_panel/deals#redirect'
end

# Update the edited deal information
post '/control_panel/deals/edit_deal' do
  session[:edited] = true

  @path = "/images/deals/#{params[:image_path]}"

  @input_name = params[:name].strip

  if @deals_db.get_first_value(
    'SELECT COUNT(1) FROM deals WHERE name = ?', params[:name].strip
  ).eql? 0
    @name_unique = true
  end

  # Check if the same deal name already exists
  ## A deal name cannot be edited into a same name with another deal
  if @deals_db.get_first_value(
    'SELECT name FROM deals WHERE deal_id = ?', session[:deal_id]
  ).eql? @input_name
    session[:edit_unique] = true
  elsif @name_unique
    session[:edit_unique] = true
  else
    session[:edit_unique] = false
  end

  # Update the information if it it's unique
  if session[:edit_unique]
    @deals_db.execute(
      'UPDATE deals SET name = ? WHERE deal_id = ?',
      params[:name].strip, session[:deal_id]
    )

    @deals_db.execute(
      'UPDATE deals SET description = ? WHERE deal_id = ?',
      params[:description].strip, session[:deal_id]
    )

    @deals_db.execute(
      'UPDATE deals SET discount = ? WHERE deal_id = ?',
      params[:discount].strip, session[:deal_id]
    )

    unless params[:image_path].eql? ''
      @deals_db.execute(
        'UPDATE deals SET image_path = ? WHERE deal_id = ?',
        @path, session[:deal_id]
      )
    end
  end

  redirect 'control_panel/deals'
end

# Delete deal(s) from the deals database
post '/control_panel/deals/delete_deal' do
  session[:deleted] = true

  @deal_id = params[:deal_id]

  # Delete the deal form the database
  (0...@deal_id.length).each do |row|
    @del = @deal_id[row].to_s.delete('[]"').to_i
    @deals_db.execute('DELETE FROM deals WHERE deal_id = ?', @del)
  end

  # Update the row otherwise errors will occur
  (0...@deal_id.length).each do |row|
    @del = @deal_id[row].to_s.delete('[]"').to_i
    @deals_db.execute(
      'UPDATE deals SET deal_id = deal_id-1 WHERE deal_id > ?', @del
    )
  end

  redirect 'control_panel/deals'
end
