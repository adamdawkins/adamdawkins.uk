class HTML::Pipeline::LineBreakFilter < HTML::Pipeline::Filter
 def call
   doc.search('.//text()').each do |node|
     content = node.text
     html = content.gsub(/\r\n/, '<br/>')
     node.replace(html) unless html == content
   end

   doc
 end
end
