require 'rubygems'


 # This code will be run each time you run your features.
require 'cucumber/rails'
require 'ruby-debug'

require 'factory_girl_rails'

Capybara.default_selector = :css
Capybara.javascript_driver = :webkit

 # Fail whenever there are rails errors.
 # Doesn't allow us to check error handling of our app.
ActionController::Base.allow_rescue = false

DatabaseCleaner.strategy = :transaction


# Stop endless errors like
# ~/.rvm/gems/ruby-1.9.2-p0@global/gems/rack-1.2.1/lib/rack/utils.rb:16: 
# warning: regexp match /.../n against to UTF-8 string
$VERBOSE = nil
