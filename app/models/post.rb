class Post < ApplicationRecord
  before_save :set_sequence
  validates_presence_of :contents

  private

    def set_sequence
      if self.published_at
        self.sequence = Post.where(published_at: Date.today.all_day).count + 1
      end

      self
    end
end
