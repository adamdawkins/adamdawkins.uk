class Article < Post
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title, presence: true
end
