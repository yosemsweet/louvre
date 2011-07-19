# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :canvas do |f|
  f.name "MyString"
  f.mission "MyText"
  f.image_url "MyString"
  f.owner_id 1
end