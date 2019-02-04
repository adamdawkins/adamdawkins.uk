module ArticlesHelper
  ArticlePipeline = HTML::Pipeline.new [
    HTML::Pipeline::MarkdownFilter,
  ]

  def blurb(article, length: 280)
    html = article_content(article.content)
    first_p = Nokogiri::HTML(html).css('p').first

    simple_format first_p.text() if first_p.present?
  end

  def article_content(content)
    ArticlePipeline.to_html(content).html_safe
  end
end
