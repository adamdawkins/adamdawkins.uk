class Post < ApplicationRecord
  validates_presence_of :content

  scope :published, -> { where("published_at IS NOT NULL").order("published_at DESC") }

  def long_url_params
    [self.published_at.year,
     self.published_at.strftime('%m'),
     self.published_at.strftime('%d'),
     self.sequence
    ]
  end

end
