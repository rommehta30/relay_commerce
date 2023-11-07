FactoryBot.define do
  factory :hit do
    user
    endpoint { Faker::Internet.url }
  end
end
