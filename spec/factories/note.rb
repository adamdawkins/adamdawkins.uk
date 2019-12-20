FactoryBot.define do
  factory :note do
    content { 'Text' }
    trait :published do
      published_at { Time.zone.now }
    end
  end
end
