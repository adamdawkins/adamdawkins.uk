FactoryBot.define do
  factory :note do
    content { "Text" }
     trait :published do
       published_at { Time.now }
    end
  end
end
