FactoryBot.define do
  factory :note do
    contents { "Text" }
     trait :published do
       published_at { Time.now }
    end
  end
end
