source 'http://rubygems.org'

# All environments.
gem 'rails', '3.0.9'
gem 'sqlite3'
gem 'nokogiri'
gem "haml-rails"
gem "compass"
gem 'omniauth', "~> 0.2.6"
gem "acts_as_opengraph", :git => "git@github.com:yosemsweet/acts_as_opengraph.git"
gem "paper_trail"  
gem 'engineyard'
gem "breadcrumbs_on_rails"
gem "html_truncator"

group :development, :test do
  gem "factory_girl_rails", :require => false
  gem "rails3-generators"
  gem "rspec-rails"
  gem "ruby-debug19"
  gem 'spork', '>=0.9.0.rc7'
  gem 'guard'
  gem 'guard-spork'
  gem 'growl'
  gem 'guard-rspec'
  gem 'guard-cucumber'
  gem "cucumber-rails"
  gem "rb-fsevent"
end

group :test do
  gem "database_cleaner"
  gem "capybara"
  gem 'capybara-webkit', :git => "git://github.com/thoughtbot/capybara-webkit"
  gem "mocha"
end

group :production do
  gem 'pg'  
end
