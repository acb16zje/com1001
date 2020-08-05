require 'capybara'
require 'capybara/cucumber'
require 'omniauth-twitter'
require 'rspec'

# Generate coverage report using SimpleCov
require 'simplecov'

SimpleCov.start do
  filters.clear # This will remove the :root_filter and :bundler_filter that come via simplecov's defaults
  add_filter do |src|
    !(src.filename =~ /^#{SimpleCov.root}/) unless src.filename =~ /pizza31/
  end

  add_filter 'features/'
end

## Replace with path to your controller
require_relative '../../../pizza31/pizza31'

ENV['RACK_ENV'] = 'test'

before do
  request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
end

OmniAuth.config.test_mode = true

OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
                                                               :provider => 'twitter',
                                                               :uid => '836670858076667904',
                                                               :info => {
                                                                 :nickname => 'pizza_31',
                                                                 :name => 'Pizza31',
                                                                 :location => 'Sheffield, England'
                                                               },
                                                               :credentials => {
                                                                 :token => '836670858076667904-fcwr7PS9ncdHWQlHOAMzsSE5E5qKPIP',
                                                                 :secret => 'jnptfNeZaK6UXqCm5nviHEP6VISxrpHwQ7dq5Iao3SzX6'
                                                               }
                                                             })

OmniAuth.config.on_failure = Proc.new {|env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}

Capybara.app = Sinatra::Application

class Sinatra::ApplicationWorld
  include RSpec::Expectations
  include RSpec::Matchers
  include Capybara::DSL
end

World do
  Sinatra::ApplicationWorld.new
end
