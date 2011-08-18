# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	
  factory :user, :aliases => [:creator] do
	  provider "facebook"
	  uid "12345"
	  name "Gill Fert"
	  image "http://www.carniola.org/theglory/images/McHammer.gif" 
  end

  factory :canvas do
    sequence :name do |n|
      "Canvas #{n}"
    end
	  mission "Better clothing for women of a certain age!"
	  image "http://www.carniola.org/theglory/images/McHammer.gif"
		creator
  end

  factory :page do
    title "My Page"
    creator
    canvas
  end

  factory :email do
    address "gill.fert@hotmail.com"
    primary 1
    user
  end

  factory :widget do
    creator
    page
    canvas
		content_type "test_content"
	end

	factory :text_widget, :parent => :widget do
   	content_type "text_content"
   	text "This is the content"
		factory :long_text_widget do
			text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. " * 100
		end
	end
	
	factory :image_widget, :parent => :widget do
		content_type "image_content"
		image "http://images2.wikia.nocookie.net/__cb20070207100739/uncyclopedia/images/3/3d/Mchammer.gif"
		alt_text "MC Hammer dancing"
	end
	
	factory :link_widget, :parent => :widget do
		content_type "link_content"
		link "http://www.loorp.com"
		title "Loorp it"
		factory :quoted_link_widget do
			text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. " * 5
		end
	end
  
  factory :tag do
    name "TagName"
  end
  
end