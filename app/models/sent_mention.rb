class SentMention < ApplicationRecord
  belongs_to :post

  validates :target, presence: true, uniqueness: { scope: :post_id }

  before_create :set_pending_status
  after_create :send_webmention

  private

  def set_pending_status
    self.status = 'pending'
  end

  def source
    Rails.application.routes.url_helpers.long_post_url(post.params)
  end

  def send_webmention
    SendWebmentionJob.perform_later(self)
  end
end
