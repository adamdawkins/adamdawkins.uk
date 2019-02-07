require 'html/pipeline'
context = {
  base_url: "https://twitter.com",
  username_pattern: /[a-z0-9][a-z0-9_]*/,
  tag_url: 'https://twitter.com/hashtag/%{tag}'
}


NotePipeline = HTML::Pipeline.new [
  HTML::Pipeline::MentionFilter,
  HTML::Pipeline::AutolinkFilter,
  HTML::Pipeline::HashtagFilter,
  HTML::Pipeline::LineBreakFilter
], context

class Note < Post
  validates :title, absence: true

  after_save :generate_link_previews

  def is_reply?
    in_reply_to.present?
  end

  def html_content
    NotePipeline.to_html(content).html_safe
  end

  def has_link_to_preview?
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
    GenerateLinkPreviewJob.perform_later(link_to_preview) if link_to_preview.present?
  end
end
