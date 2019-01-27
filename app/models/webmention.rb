class Webmention < ApplicationRecord
  belongs_to :post
  validates_presence_of :target
  before_create :set_pending_status
  after_create :send_webmention

  private

  def set_pending_status
    self.status = "pending"
  end

  def source
    Rails.application.routes.url_helpers.long_post_url(post.params)
  end

  def send_webmention
    WebmentionService.new(source, target)
  end
end
