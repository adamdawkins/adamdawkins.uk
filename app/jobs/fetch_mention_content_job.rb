class FetchMentionContentJob < ApplicationJob
  queue_as :default

  def perform(mention)
    url = mention.source
    html = HTTParty.get(url).andand.body
    collection = Microformats.parse(html)

    pp "No h-entry found at #{url}" and return unless collection.respond_to?(:entry)
    
    mention.update(
      title: collection.entry.try("name"),
      content: collection.entry.try("content").try("value")
    )
  end
end
