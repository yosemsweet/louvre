# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :events do
      canvas_id 1
      loggable_id 1
      loggable_type "MyString"
      user_id 1
      description "MyString"
    end
end