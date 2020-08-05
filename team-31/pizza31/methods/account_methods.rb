# Methods used on control panel page #
def disable_cache
  response.headers['Cache-Control'] = 'no-cache, no-store,
                                       max-age=0, must-revalidate'
  response.headers['Pragma'] = 'no-cache'
  response.headers['Expires'] = 'Fri, 01 Jan 1970 00:00:00 GMT'
end

def get_account_name(username)
  @accounts_db.get_first_value(
    'SELECT name FROM accounts WHERE username LIKE "%" || ? || "%"',
    username
  )
end

def get_account_email(username)
  @accounts_db.get_first_value(
    'SELECT email FROM account_email WHERE username LIKE "%" || ? || "%"',
    username
  )
end

def get_account_phone(username)
  @accounts_db.get_first_value(
    'SELECT phone FROM account_phone WHERE username LIKE "%" || ? || "%"',
    username
  )
end

def get_account_address(username)
  @accounts_db.get_first_value(
    'SELECT address FROM account_address WHERE username LIKE "%" || ? || "%"',
    username
  )
end

def get_account_location(username)
  @accounts_db.get_first_value(
    'SELECT location FROM account_location WHERE username LIKE "%" || ? || "%"',
    username
  )
end

def get_account_postcode(username)
  @accounts_db.get_first_value(
    'SELECT postcode FROM account_postcode WHERE username LIKE "%" || ? || "%"',
    username
  )
end

def get_account_status(username)
  @accounts_db.get_first_value(
    'SELECT status.status FROM status JOIN account_status
    ON account_status.status_id = status.status_id
    WHERE username LIKE "%" || ? || "%"', username
  )
end

def delete_all_accounts
  @accounts_db.execute('DELETE FROM accounts')
end

def delete_all_account_phone
  @accounts_db.execute('DELETE FROM account_phone')
end

def delete_all_account_address
  @accounts_db.execute('DELETE FROM account_address')
end

def delete_all_account_location
  @accounts_db.execute('DELETE FROM account_location')
end

def delete_all_account_postcode
  @accounts_db.execute('DELETE FROM account_postcode')
end

def delete_all_account_email
  @accounts_db.execute('DELETE FROM account_email')
end

def delete_all_account_status
  @accounts_db.execute('DELETE FROM account_status')
end

# Make the account as admin account
def make_default_admin
  @accounts_db.execute(
    'INSERT INTO account_status VALUES (?, ?)',
    session[:username], 1
  )
end

def make_loyal_customer
  @accounts_db.execute(
    'UPDATE account_status SET status_id = ? WHERE username = ?',
    2, session[:username]
  )
end

# Make the account as regular account
def make_regular_customer
  @accounts_db.execute(
    'INSERT INTO account_status VALUES (?, ?)',
    session[:username], 3
  )
end
