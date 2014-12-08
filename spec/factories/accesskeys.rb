# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :accesskey do
    client_id "MyString"
    client_secret "MyString"
    callback_url "MyString"
    source_url "MyString"
  end
end
