# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :user do |f|
  f.provider "MyString"
  f.uid "MyString"
  f.name "MyString"
  f.image "MyString"
  f.email "MyString"
end