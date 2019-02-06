class LinkPreview < ApplicationRecord
  validates :url, presence: true, uniqueness: true
  validates :title, presence: true

  def self.from_link(url)
    where(url: url).first_or_initialize.tap do |link_preview|
      return link_preview if link_preview.persisted?
      puts "New link"
      page = HTTParty.get(url) 
      microformats_preview = microformats(page.body)
      unless microformats_preview.nil?
        microformats_preview.each do |key, value|
          pp "#{key}: #{value}"
          link_preview[key] = value
        end
      end
      link_preview.save!
    end
    # Given a URL, we try and find a preview by:
    # [x] Checking for microformats on the page
    # [ ] Checking for opengraph
    # [ ] checking for Twitter card?
    # [ ] checking for oEmbed?
    
  end

  private
  def self.microformats(html)
    collection = Microformats.parse(html)
    return nil unless collection.respond_to?(:entry)
    preview = {}
    preview[:title] = collection.entry.try("name")
    preview[:image] = collection.entry.try("photo") || collection.entry.try("author").try("photo")
    preview[:author_name] = collection.entry.try("author").try("name")
    preview[:author_url] = collection.entry.try("author").try("url")
    preview[:summary] = collection.entry.try("summary")

    preview
  end
end
