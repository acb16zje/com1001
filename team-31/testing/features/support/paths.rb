module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

      when /the non-existing page/
        '/somerandompage'

      when /the server\s?error\s?page/
        '/div'

      when /the invalid\s?login\s?page/
        '/auth/failure'

      when /the logout page/
        '/logout'

      when /the home\s?page/
        '/index'

      when /the profile page/
        '/profile'

      when /the order history page/
        '/order_history'

      when /the special offers page/
        '/special_offers'

      when /the menu\s?page/
        '/menu'

      when /the deals\s?page/
        '/deals'

      when /the order\s?page/
        '/order'

      when /the about\s?us\s?page/
        '/about'

      when /the contact\s?us\s?page/
        '/contact'

      when /the accessibility page/
        '/accessibility'

      when /the control\s?panel\s?page/
        '/control_panel'

      when /the menu\s?control\s?panel\s?page/
        '/../control_panel/menu'

      when /the deals\s?control\s?panel\s?page/
        '/../control_panel/deals'
        
      when /the Sheffield orders\s?control\s?panel\s?page/
        '/../control_panel/sheffield_orders'

      when /the London orders\s?control\s?panel\s?page/
        '/../control_panel/london_orders'

      when /the special\s?offers\s?control\s?panel\s?page/
        '/../control_panel/special_offers'

      when /the Sheffield\s?sales\s?control\s?panel\s?page/
        '/../control_panel/sheffield_sales'

      when /the London\s?sales\s?control\s?panel\s?page/
        '/../control_panel/london_sales'

      when /the accounts\s?control\s?panel\s?page/
        '/../control_panel/accounts'

      # Add more mappings here.
      # Here is an example that pulls values out of the Regexp:
      #
      #   when /^(.*)'s profile page$/i
      #     user_profile_path(User.find_by_login($1))

      else
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
                "Now, go and add a mapping in #{__FILE__}"

    end
  end
end

World(NavigationHelpers)

get '/div' do
  0 / 0
end
