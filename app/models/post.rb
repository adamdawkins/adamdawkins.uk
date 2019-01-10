class Post < ApplicationRecord
  before_save :set_sequence
  validates_presence_of :contents

  scope :published, -> { where("published_at IS NOT NULL").order("published_at DESC") }

  def long_url_params
    [self.published_at.year,
     self.published_at.strftime('%m'),
     self.published_at.strftime('%d'),
     self.sequence
    ]
  end

  private

    def set_sequence
      if self.published_at
        self.sequence = Post.where(published_at: Date.today.all_day).count + 1
      end

      self
    end
end
