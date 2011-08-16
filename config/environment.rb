# Load the rails application
require File.expand_path('../application', __FILE__)

# change the default directory for sass generated stylesheets
Sass::Plugin.options[:template_location] = {
  "#{::Rails.root.to_s}/app/stylesheets" => "#{::Rails.root.to_s}/public/stylesheets/compiled"
}

# Initialize the rails application
Louvre::Application.initialize!
