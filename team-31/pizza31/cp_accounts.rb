# Back end file for displaying the registered account
# Also allows admin to modify the account status

# Control Panel - Accounts
get '/control_panel/accounts' do
  if session[:admin].eql? 1
    @accounts = 'active'
    @deleted_all_accounts = session.delete(:deleted_all_accounts)
    @status_modified = session.delete(:status_modified)

    @account_count = @accounts_db.get_first_value(
      'SELECT COUNT(1) FROM accounts'
    )

    @status_list = @accounts_db.execute(
      'SELECT status_id FROM status'
    )

    erb :'back_end/accounts'
  else
    not_found
  end
end

get '/control_panel/accounts/change_status' do
  session[:status_modified] = true
  @accounts_db.execute(
    'UPDATE account_status SET status_id = ? WHERE username = ?',
    params[:status_id], params[:username]
  )

  redirect 'control_panel/accounts'
end

# Delete all the accounts stored in accounts.sqlite
post '/control_panel/accounts/delete_all' do
  session[:deleted_all_accounts] = true
  delete_all_accounts
  delete_all_account_phone
  delete_all_account_address
  delete_all_account_location
  delete_all_account_postcode
  delete_all_account_email
  delete_all_account_status

  redirect 'control_panel/accounts'
end
