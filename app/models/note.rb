class Note < Post
  validates :title, absence: true

  def is_reply?
    in_reply_to.present?
  end
end
