ArticlePipeline = HTML::Pipeline.new [
  HTML::Pipeline::MarkdownFilter,
]

class Article < Post
  validates :title, presence: true

  def html_content
    ArticlePipeline.to_html(content).html_safe
  end

  def blurb(length: 280)
    Nokogiri::HTML(html_content).css('p').first.andand.to_html.andand.html_safe
  end
end
