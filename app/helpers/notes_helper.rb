require 'html/pipeline'
context = {
  base_url: "https://twitter.com",
  username_pattern: /[a-z0-9][a-z0-9_]*/i,
  tag_url: 'https://twitter.com/hashtag/%{tag}'
}


NotePipeline = HTML::Pipeline.new [
  HTML::Pipeline::MentionFilter,
  HTML::Pipeline::AutolinkFilter,
  HTML::Pipeline::HashtagFilter,
  HTML::Pipeline::LineBreakFilter,
], context



module NotesHelper
  def note_content(note)
      html = NotePipeline.to_html(note.content).html_safe
  end

  def reply_text(link)
    tweet = link.match(/twitter.com\/(\w*)\//)
    return link if tweet.nil?

    "@#{tweet[1]}'s tweet"
  end
end
