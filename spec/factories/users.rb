FactoryBot.define do
  factory :user do
    name { 'testuser' }
    email { 'test@gmail.com' }
    password { 'password' }
  end
end