# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :canvas do |f|
  f.name "Fashion of a Certain Age"
  f.mission "Better clothing for women of a certain age!"
  f.image_url "http://www.carniola.org/theglory/images/McHammer.gif"
	f.association :creator, :factory => :user
end