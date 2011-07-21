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
	  name "Fashion of a Certain Age"
	  mission "Better clothing for women of a certain age!"
	  image_url "http://www.carniola.org/theglory/images/McHammer.gif"
		creator
  end

  factory :page do
    title "MyString"
    creator
    canvas
  end
  
  

end