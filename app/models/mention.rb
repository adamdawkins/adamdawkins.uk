class Mention < ApplicationRecord
  belongs_to :post

  before_validation(on: :create) { find_post_from_target }
  after_create :fetch_mention_content

  private
  def find_post_from_target
    blank, year, month, day, slug = URI.parse(self.target).path.split("/")
    date = Date.new(year.to_i, month.to_i, day.to_i)
    post = Post.where(published_at: date.all_day, slug: slug).first
    pp ["Post", post]
    self.post = post
  end

  def fetch_mention_content
    FetchMentionContentJob.perform_later(self)
  end
end
