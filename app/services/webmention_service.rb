require 'httparty'
require 'nitlink/response'

Parser = URI::Parser.new

class WebmentionService
  attr_reader :endpoint

  def initialize(source, target)
    @source = source
    @target = target
    @response = HTTParty.get(@target)
    @endpoint = to_absolute_url(@target, discover_endpoint)
  end

  def send
    return if @endpoint.nil?
    response = HTTParty.post(@endpoint, { body: {target: @target, source: @source }})
    pp response
  end

  private

  def discover_endpoint
    header_endpoint = discover_endpoint_from_http_header
    return header_endpoint if header_endpoint
    link_endpoint = discover_endpoint_from_document
    return link_endpoint
  end

  def discover_endpoint_from_http_header
    header_link = @response.links.by_rel('webmention')

    res = header_link.andand.target.andand.to_s
    res
  end

  def set_doc
    @doc = Nokogiri::HTML(@response.body)
  end

  def discover_endpoint_from_document
    set_doc
    href = @doc.at_css('[rel~="webmention"][href]').andand[:href]
  end


  def to_absolute_url(origin, target)
    Parser.parse(origin).merge(Parser.parse(target)).to_s
  end
end
