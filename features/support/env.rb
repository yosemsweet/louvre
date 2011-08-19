require 'rubygems'


 # This code will be run each time you run your features.
require 'cucumber/rails'
require 'ruby-debug'

require 'sauce'
require 'sauce/capybara'

Sauce.config do |config|
  config.username = "moosefan"
  config.access_key = "a095bc4f-0125-4058-84cf-d4abeb13e7b5"
  config.browser = "googlechrome"
  config.os = "Windows 2003"
  config.browser_version = ""
end

require 'factory_girl_rails'

Capybara.default_selector = :css
Capybara.javascript_driver = :webkit
Capybara.default_wait_time = 5

 # Fail whenever there are rails errors.
 # Doesn't allow us to check error handling of our app.
ActionController::Base.allow_rescue = false

DatabaseCleaner.strategy = :transaction


# Stop endless errors like
# ~/.rvm/gems/ruby-1.9.2-p0@global/gems/rack-1.2.1/lib/rack/utils.rb:16: 
# warning: regexp match /.../n against to UTF-8 string
$VERBOSE = nil
