module ArticlesHelper
  def blurb(article, length: 280)
    html = Kramdown::Document.new(article.content).to_html.html_safe
    first_p = Nokogiri::HTML(html).css('p').first

    simple_format first_p.text() if first_p.present?
  end
end
