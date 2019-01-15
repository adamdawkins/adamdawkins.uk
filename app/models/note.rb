class Note < Post
  validates :title, absence: true

  def published?
    published_at.present?
  end
end
