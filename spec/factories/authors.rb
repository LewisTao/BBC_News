FactoryGirl.define do
  factory :author do
    email { FFaker::Internet.email }
    password '12345678'
    password_confirmation '12345678'
    name { FFaker::Name.name }
  end

end
