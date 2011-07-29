# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	
  factory :user, :aliases => [:creator] do
	  provider "facebook"
	  uid "12345"
	  name "Gill Fert"
	  image "http://www.carniola.org/theglory/images/McHammer.gif"
	  email "gill.fert@foaca.org"
  end

  factory :canvas do
    sequence :name do |n|
      "Canvas #{n}"
    end
	  mission "Better clothing for women of a certain age!"
	  image_url "http://www.carniola.org/theglory/images/McHammer.gif"
		creator
  end

  factory :page do
    title "My Page"
    creator
    canvas
  end

  factory :widget, :aliases => [:text_widget, :image_widget] do
    content_type "text_content"
    content "This is the content"
    creator
    page
    canvas
  end

	factory :comment do
		content "This is a great comment"
		creator
		widget
	end

end