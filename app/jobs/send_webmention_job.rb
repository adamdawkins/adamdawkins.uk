class SendWebmentionJob < ApplicationJob
  queue_as :default

  def perform(webmention)
    @sender = WebmentionSender.new(webmention.post.andand.full_url,
                                   webmention.target)
    @sender.send

    webmention.update(status: @sender.status)
  end
end
