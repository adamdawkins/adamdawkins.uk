class FetchMentionContentJob < ApplicationJob
  queue_as :default

  def perform(mention)
    html = HTTParty.get(mention.source).andand.body
    collection = Microformats.parse(html)

    if collection.respond_to?(:entry)
      entry = collection.entry
      update_with_content(mention, entry)
      mention.update(is_like: true) if entry["properties"]["like-of"].andand.include?(mention.target)
    end
  end

  def update_with_content(mention, entry)
    mention.update(
      title: entry.try("name"),
      photo: entry.try("author").try("photo"),
      content: entry.try("content").try('value')
    )
  end
end
