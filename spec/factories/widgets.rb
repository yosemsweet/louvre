# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :widget do
      name "MyString"
      position 1
      page_id 1
      canvas_id 1
      creator_id 1
      content_id 1
      content_type "MyString"
    end
end