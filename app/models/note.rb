class Note < Post
  validates :title, absence: true
end
