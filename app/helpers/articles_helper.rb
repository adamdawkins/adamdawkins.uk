module ArticlesHelper
  def blurb(article, length: 280)
    html = Kramdown::Document.new(article.content).to_html.html_safe
    first_paragraph = Nokogiri::HTML(html).css('p').first.text()
    simple_format first_paragraph
  end
end
