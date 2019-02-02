FactoryBot.define do
  factory :task do
    name { 'write test' }
    description { 'ready rspec capybara and factorybot' }
    user
  end
end