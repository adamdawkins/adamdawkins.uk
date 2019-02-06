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

  def is_reply?
    in_reply_to.present?
  end

  def html_content
    NotePipeline.to_html(content).html_safe
  end
end
