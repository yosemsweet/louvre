require 'rubygems'
require 'spork'
 
Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
	require 'ruby-debug'
 
  RSpec.configure do |config|
    config.mock_with :mocha
    config.use_transactional_fixtures = true
  end
  
end
 
Spork.each_run do
	require 'factory_girl_rails'
	Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
end
require 'sauce'

Sauce.config do |conf|
    conf.browser_url = "http://loorp.com/"
    conf.browsers = [
        ["Windows 2008", "firefox", "4.0"]
    ]
    conf.application_host = "127.0.0.1"
    conf.application_port = "3001"
end
