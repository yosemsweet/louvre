# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :user do |f|
  f.provider "facebook"
  f.uid "12345"
  f.name "Gill Fert"
  f.image "http://www.carniola.org/theglory/images/McHammer.gif"
  f.email "gill.fert@foaca.org"
end