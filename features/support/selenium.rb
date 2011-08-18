Before ('@selenium') do
Capybara.register_driver :selenium do |app|
 require 'selenium/webdriver'
 profile = Selenium::WebDriver::Firefox::Profile.new
 Capybara::Selenium::Driver.new(app, :profile => profile, :resynchronize => true)
 end
Capybara.current_driver = :selenium
end

After ('@selenium') do
  Capybara.use_default_driver
end
