class GenerateLinkPreviewJob < ApplicationJob
  queue_as :default

  def perform(url)
    LinkPreview.from_url(url)
  end
end
