class Note < Post
  validates :title, absence: true

  after_save :generate_link_previews

  def reply?
    in_reply_to.present?
  end

  # rubocop:disable Rails/OutputSafety
  def html_content
    NotePipeline.to_html(content).html_safe
  end
  # rubocop:enable Rails/OutputSafety

  def link_to_preview?
    link_to_preview.present? && link_preview.present?
  end

  def link_to_preview
    doc = HTML::Pipeline.parse(html_content.to_str)
    last_elem = doc.children.last
    last_elem[:href] if last_elem.andand.name == 'a'
  end

  def link_preview
    LinkPreview.find_by(url: link_to_preview) if link_to_preview.present?
  end

  private

  def generate_link_previews
    GenerateLinkPreviewJob.perform_later(link_to_preview) if
    link_to_preview.present?
  end
end
