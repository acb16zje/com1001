# Main application controller #
# All required gems
require 'erb'
require 'omniauth-twitter'
require 'sinatra'
require 'sqlite3'
require 'twitter'
require 'uk_postcode'

# Back end files
require_relative 'authentication'
require_relative 'cp_sales'
require_relative 'cp_accounts'
require_relative 'cp_deals'
require_relative 'cp_menu'
require_relative 'cp_orders'
require_relative 'cp_special_offers'
require_relative 'error_handling'
require_relative 'front_end'

# Methods used in controller
require_relative 'methods/account_methods'
require_relative 'methods/deals_methods'
require_relative 'methods/orders_methods'
require_relative 'methods/pizza_methods'
require_relative 'methods/special_offers_methods'

set :bind, '0.0.0.0' # Only needed if you're running from Codio

use Rack::Session::Cookie, :key => 'rack.session',
    :path => '/',
    :secret => 'superomega_secret'

include ERB::Util

# Disable the exceptions and SQLite errors
disable :raise_errors
disable :show_exceptions

# OmniAuth login
use OmniAuth::Builder do
  provider :twitter, 'ebNTf95exF6GWaIH6SVSCAFNY', 'lC6It60YFT5WUk2aQ1M78QhdVmu5e2W57cFO4RjluREIVUsJ5l'
end

# Load the database, disable cache, and configure admin Twitter handle
before do
  @accounts_db = SQLite3::Database.open '../databases/accounts.sqlite'
  @deals_db = SQLite3::Database.open '../databases/deals.sqlite'
  @orders_db = SQLite3::Database.open '../databases/orders.sqlite'
  @menu_db = SQLite3::Database.open '../databases/pizzas.sqlite'
  @special_db = SQLite3::Database.open '../databases/special_offers.sqlite'

  disable_cache

  # Admin Twitter handle
  config = {
    :consumer_key => 'ebNTf95exF6GWaIH6SVSCAFNY',
    :consumer_secret => 'lC6It60YFT5WUk2aQ1M78QhdVmu5e2W57cFO4RjluREIVUsJ5l',
    :access_token => '836670858076667904-fcwr7PS9ncdHWQlHOAMzsSE5E5qKPIP',
    :access_token_secret => 'jnptfNeZaK6UXqCm5nviHEP6VISxrpHwQ7dq5Iao3SzX6'
  }

  @admin_tweet = Twitter::REST::Client.new(config)

  # Total items in the basket
  if session[:logged_in]
    session[:total_items] = 0
    @orders_db.execute('SELECT quantity FROM basket WHERE username = ?', session[:username]).each do |item|
      session[:total_items] += item.to_s.delete('[]').to_i
    end
  else
    session[:total_items] = 0
  end
end
