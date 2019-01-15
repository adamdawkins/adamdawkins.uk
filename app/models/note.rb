class Note < Post
  validates :title, absence: true

  def published?
    published_at.present?
  end

  def publish
    self.published_at = Time.now
  end

  def publish!
    publish
    save
  end
end
