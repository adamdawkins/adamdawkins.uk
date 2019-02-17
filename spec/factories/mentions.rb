FactoryBot.define do
  factory :mention do
    post { nil }
    source { "MyString" }
    title { "MyString" }
    content { "MyString" }
    in_reply_to { "MyString" }
  end
end
