class LinkPreviewGenerator
  # attr_reader :html, :url, :title, :image,
  #             :author_name, :author_url, :summary

  def initialize(url)
    @url = url
    @html = HTTParty.get(url).andand.body
  end

  def to_hash
    # Given a URL, we try and find a preview by:
    # [x] Checking for microformats on the page
    # [x] Checking for opengraph
    # [ ] checking for Twitter card?
    # [ ] checking for oEmbed?

    # Microformats takes precedent over Open Graph
    microformat_response.reverse_merge(opengraph_response)
  end

  def microformat_response
    entry = Microformats.parse(@html)&.entry
    return {} if entry.nil?

    {
      title: entry.try('name'),
      image: entry.try('photo'),
      author_name: entry.try('author').try('name'),
      author_url: entry.try('author').try('url'),
      summary: entry_summary(entry)
    }.select { |_, v| v.present? }
  end

  def opengraph_response
    doc = Nokogiri::HTML::DocumentFragment.parse(@html)
    og_properties = {}
    doc.css('meta[property^="og:"]').each do |meta|
      og_properties[meta.attribute('property').to_s.gsub('og:', '')] =
        meta.attribute('content').to_s
    end
    og_to_link_preview og_properties
  end

  def og_to_link_preview(opengraph)
    # Maps open graph properties to what we currently have in our schema,
    # (We've already stripped the `og:`)
    { title: opengraph['title'],
      image: opengraph['image'],
      summary: opengraph['description'].truncate(300),
      author_name: opengraph['article:author'] }
  end

  private

  def entry_summary(entry)
    entry.try('summary') || first_line_of_content(entry)
  end

  def first_line_of_content(entry)
    entry.try('content').to_hash[:value].split('\n')[0]
  end
end
