class Repost < Post
  validates :title, absence: true
  validates :repost_of, presence: true
end
