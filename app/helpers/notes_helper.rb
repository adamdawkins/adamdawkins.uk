module NotesHelper
  def note_content(note)
    line_breaks(
      auto_link(note.content)
    )
  end

  def line_breaks(text)
    text.gsub(/(\r\n)/, '<br/>').html_safe
  end

  def reply_text(link)
    tweet = link.match(/twitter.com\/(\w*)\//)
    return link if tweet.nil?

    "@#{tweet[1]}'s tweet"
  end
end
