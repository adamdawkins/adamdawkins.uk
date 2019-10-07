FactoryBot.define do
  factory :repost do
    content { "Text" }
    repost_of { "http://example.com" }
    trait :published do
      published_at { Time.now }
    end
  end
end
