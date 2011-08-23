# when a scenario fails, a screen shot and HTML version of the page is saved
# into tmp/capybara automatically
# http://blog.mattheworiordan.com/post/9120359890/cucumber-and-capybara-webkit-automatic-screenshots

def screen_shot_and_save_page
  require 'capybara/util/save_and_open_page'
  path = "/#{Time.now.strftime('%Y-%m-%d-%H-%M-%S')}"
  Capybara.save_page body, "#{path}.html"
  page.driver.render Rails.root.join "#{Capybara.save_and_open_page_path}" "#{path}.png"
end

begin
  After do |scenario|
    screen_shot_and_save_page if scenario.failed?
  end
rescue Exception => e
  puts "Snapshots not available for this environment.\n
    Have you got gem 'capybara-webkit' in your Gemfile and have you enabled the javascript driver?"
end