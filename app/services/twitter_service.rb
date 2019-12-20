TwitterClient = Twitter::REST::Client.new do |config|
  twitter_credentials = Rails.application.credentials.twitter
  config.consumer_key = twitter_credentials[:consumer_key]
  config.consumer_secret = twitter_credentials[:consumer_secret]
  config.access_token = twitter_credentials[:access_token]
  config.access_token_secret = twitter_credentials[:access_token_secret]
end

MAX_TWEET_LENGTH = 280

class TwitterService
  def self.status_id_from_tweet_url(url)
    match = url.match(%r{twitter.com/.*/(\d*)\??.*$})
    return match[1].to_i unless match.nil?
  end

  def self.destroy(url)
    return logger.info 'Not deleting tweet in dev' unless Rails.env.production?

    logger.info "Deleting tweet at #{url}"
    TwitterClient.destroy_tweet(url)
  end

  def self.post(post)
    tweet = adjust_tweet_length(post.content.gsub!('*', '＊'))

    if post.reply?
      in_reply_to_status_id = status_id_from_tweet_url(post.in_reply_to)
    end

    response = TwitterClient.update(
      tweet,
      tweet_mode: 'extended',
      in_reply_to_status_id: in_reply_to_status_id
    )

    post.syndicates.create(silo: twitter_silo, url: response.url.to_str)
  end

  def self.adjust_tweet_length(tweet)
    return tweet if tweet.length <= MAX_TWEET_LENGTH

    url = "https://#{ENV['SHORT_URL']}/#{post.id}"

    # extra 10, don't know why it's needed yet
    cut_off = MAX_TWEET_LENGTH - 23 - 4 - 10

    "#{tweet[0..(cut_off - 1)]}... #{url}"
  end

  def twitter_silo
    Silo.find_by(name: 'Twitter')
  end
end
