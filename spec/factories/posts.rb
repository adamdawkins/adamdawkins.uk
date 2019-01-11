FactoryBot.define do
  factory :post do
    content { "Text" }
    type { Note }
     trait :published do
       published_at { Time.now }
    end
  end
end
