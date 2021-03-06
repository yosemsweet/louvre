# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	
  factory :user, :aliases => [:creator, :editor] do
	  provider "facebook"
    sequence :uid do |n|
      "00#{n}"
    end
    sequence :name do |n|
      "User #{n}"
    end
	  image "http://www.carniola.org/theglory/images/McHammer.gif" 
	  admin false
	  last_action Time.now
  end

  factory :canvas do
    sequence :name do |n|
      "Canvas #{n}"
    end
	  image "http://www.carniola.org/theglory/images/McHammer.gif"
		creator
		editor
  end

  factory :event do
    canvas
    user
    loggable_id 1
    loggable_type "Page"
    description "This is an event description"
  end
  
  factory :page do
    title "My Page"
    creator
    editor
    canvas
  end

  factory :email do
    address "gill.fert@hotmail.com"
    primary 1
    user
  end
  
  factory :canvas_widget do
    creator
		editor
    canvas
		content_type "test_content"
	end

  factory :widget do
    creator
		editor
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
  
  factory :question_widget, :parent => :widget do
   	content_type "question_content"
   	question "Am I a question?"
   	answer [{:message => "This is an answer.", :commenter => "Bob Dylan", :comment_date => 15.minutes.ago}].to_json
	end
  
  factory :tag do
    name "TagName"
  end

	factory :canvas_user_role do
		user
		canvas
		role :member 
	end
  
end