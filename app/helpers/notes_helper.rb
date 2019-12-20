module NotesHelper
  def reply_text(link)
    tweet = link.match(%r{twitter.com/(\w*)/})
    return link if tweet.nil?

    "@#{tweet[1]}'s tweet"
  end
end
