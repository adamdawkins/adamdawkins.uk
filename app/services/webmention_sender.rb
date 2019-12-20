require 'httparty'
require 'nitlink/response'

Parser = URI::Parser.new

class WebmentionSender
  attr_reader :endpoint, :status

  def initialize(source, target)
    @source = source
    @target = target
    @response = HTTParty.get(@target)
    set_endpoint
    @status = 'intialized'
  end

  def success?
    @status == 'success'
  end

  def send
    return @status = 'no_endpoint' if @endpoint.nil?

    response = HTTParty.post(@endpoint,
                             body: { target: @target, source: @source })
    @status = 'success' if response.code.between?(200, 299)
  end

  private

  def discover_endpoint
    header_endpoint = discover_endpoint_from_http_header
    return header_endpoint if header_endpoint

    link_endpoint = discover_endpoint_from_document
    link_endpoint
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
    @doc.at_css('[rel~="webmention"][href]').andand[:href]
  end

  def to_absolute_url(origin, target)
    Parser.parse(origin).merge(Parser.parse(target)).to_s
  rescue StandardError
    nil
  end

  def endpoint_valid?(endpoint)
    host = Parser.parse(endpoint).andand.host
    !(host.andand.match(/127\.0\.0\..*/) || host == 'localhost')
  rescue StandardError
    false
  end

  def set_endpoint
    discovered_endpoint = discover_endpoint
    return unless endpoint_valid?(discovered_endpoint)

    @endpoint = to_absolute_url(@target, discovered_endpoint)
  end
end
