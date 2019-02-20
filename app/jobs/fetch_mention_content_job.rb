class FetchMentionContentJob < ApplicationJob
  queue_as :default

  def perform(mention)
    html = HTTParty.get(mention.source).andand.body
    collection = Microformats.parse(html)

    if collection.respond_to?(:entry)
      entry = collection.entry

      if entry["properties"]["like-of"].andand.include?(mention.target)
        mention.update(is_like: true)
      else
        update_with_content(mention, entry)
      end
    end
  end

  def update_with_content(mention, entry)
    mention.update(
      title: entry.try("name"),
      content: entry.try("content").andand.to_hash[:value]
    )
  end
end
