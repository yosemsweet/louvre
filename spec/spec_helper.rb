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
