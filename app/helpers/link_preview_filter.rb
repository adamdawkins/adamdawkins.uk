class LinkPreviewFilter < HTML::Pipeline::Filter
  # How to decide if to show a preview?
  # 1. if there's one link in the note
  # 2. if link is last thing in note
  # 3. TODO: exclude mentions from link count
  
  # Parsing
  # 1. Microformats
  # 2. OpenGraph
  # 3. oEmbed?
  # 4. Twitter Card?

  def call
    last_elem = doc.children.last
    pp "CALL"
    pp last_elem.name
    if last_elem.name() == 'a'
      url = last_elem[:href]
      response = HTTParty.get(url)
      pp response.headers
      mf_response = microformats_preview(response)
      if mf_response
      end
      content = render_preview(title: "The sex slave who refused to be silenced")
    end
  
    content || doc
  end

  def microformats_preview(source)
    collection = Microformats.parse(source)
    return "no microformats" unless collection.respond_to?(:entry)
    collection.entry
  end

  def render_preview(args = {})
    doc = Nokogiri::HTML('<div class="link-preview"></div>')
    if args[:image]
      doc.create_element "img", src: args[:image]
    end
#   <img src="https://external.flhr2-1.fna.fbcdn.net/safe_image.php?d=AQAlNTECrXUde83V&w=540&h=282&url=https%3A%2F%2Fichef.bbci.co.uk%2Fnews%2F1024%2Fbranded_news%2FA747%2Fproduction%2F_105432824_620f6b27-13a9-4df4-85e7-0a16814ad6b6.jpg&cfs=1&upscale=1&fallback=news_d_placeholder_publisher&_nc_hash=AQDbFqNwGFkcJhlv" />
#   <div class="link-preview__content">
#     <span class="link-preview__domain"><a href="https://bbc.co.uk" class="underline">bbc.com</a></span>
#     <h4 class="link-preview__title">The sex slave who refused to be silenced</h4>
#     <p class="link-preview__description">The film, based on a Kevin Grisham novel (John Grisham\'s brother), revolves around a Southern-born lawyer named Contstance Justice</p>
#   </div>
# </div>'
#     )
  end
end
