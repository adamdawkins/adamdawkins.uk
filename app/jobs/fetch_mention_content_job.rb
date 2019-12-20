class FetchMentionContentJob < ApplicationJob
  queue_as :default

  def perform(mention)
    html = HTTParty.get(mention.source).andand.body
    entry = Microformats.parse(html)&.entry

    return if entry.nil?

    update_with_content(mention, entry)
    update_mention_for_likes(mention, entry)
  end

  def update_with_content(mention, entry)
    mention.update(
      title: entry.try('name'),
      photo: entry.try('author').try('photo'),
      content: entry.try('content').try('value')
    )
  end

  def update_mention_for_likes(mention, entry)
    return unless entry['properties']['like-of'].andand.include?(mention.target)

    mention.update(is_like: true)
  end
end
