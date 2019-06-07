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
    # [ ] Checking for opengraph
    # [ ] checking for Twitter card?
    # [ ] checking for oEmbed?
   
    # Microformats takes precedent over Open Graph
    microformat_response.reverse_merge(opengraph_response)
  end


  def microformat_response
    pp "microformats"
    collection = Microformats.parse(@html)
    return {} unless collection.respond_to?(:entry)
    {
      title: collection.entry.try("name"),
      image: collection.entry.try("photo"),
      author_name: collection.entry.try("author").try("name"),
      author_url: collection.entry.try("author").try("url"),
      summary: collection.entry.try("summary") || collection.entry.try("content").to_hash[:value].split("\n")[0],
    }.select {|k, v| v.present? }
  end

  def opengraph_response
    pp "Opengraph"
    doc = Nokogiri::HTML::DocumentFragment.parse(@html)
    og_properties = {}
    doc.css('meta[property^="og:"]').each do |meta|
      og_properties[meta.attribute('property').to_s.gsub('og:', '')] = meta.attribute('content').to_s
    end
    og_to_link_preview og_properties
  end

  def og_to_link_preview(og)
    # Maps open graph properties to what we currently have in our schema,
    # (We've already stripped the `og:`)
    { title: og["title"],
      image: og["image"],
      summary: og["description"],
      author_name: og["article:author"] }
  end
end
