# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :page do |f|
  f.title "MyString"
	f.association :creator, :factory => :user
	f.association :canvas, :factory => :canvas
	
end