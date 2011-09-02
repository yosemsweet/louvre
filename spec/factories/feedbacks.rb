# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :feedback do
      user_id 1
      interested_in "MyString"
    end
end