ArticlePipeline = HTML::Pipeline.new [
  HTML::Pipeline::MarkdownFilter
]

# rubocop:disable Rails/OutputSafety
class Article < Post
  validates :title, presence: true

  def html_content
    ArticlePipeline.to_html(content).html_safe
  end

  def blurb
    Nokogiri::HTML(html_content).css('p').first.andand.to_html.andand.html_safe
  end
end
# rubocop:enable Rails/OutputSafety
