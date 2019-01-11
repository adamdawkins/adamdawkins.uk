FactoryBot.define do
  factory :article do
    title { Faker::Book.title }
    contents { Faker::Lorem.paragraph }
  end
end
