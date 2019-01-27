TwitterClient = Twitter::REST::Client.new do |config|
  config.consumer_key = Rails.application.credentials.twitter[:consumer_key]
  config.consumer_secret = Rails.application.credentials.twitter[:consumer_secret]
  config.access_token = Rails.application.credentials.twitter[:access_token]
  config.access_token_secret = Rails.application.credentials.twitter[:access_token_secret]
end

MAX_TWEET_LENGTH = 280

class TwitterService
  def self.status_id_from_tweet_url(url)
    match = url.match(/twitter.com\/.*\/(\d*)\??.*$/)
    return match[1].to_i unless match.nil?
  end
  def self.destroy(url)
    pp "Deleting tweet at #{url}"
    TwitterClient.destroy_tweet(url)
  end
  def self.post(post)
    tweet = post.content
    tweet.gsub!('*', '＊')
    tweet = adjust_tweet_length(tweet)
    if post.is_reply?
      in_reply_to_status_id = status_id_from_tweet_url(post.in_reply_to)
    end
    pp [tweet, in_reply_to_status_id.to_i]

    response = TwitterClient.update(tweet, tweet_mode: 'extended', in_reply_to_status_id: in_reply_to_status_id)

    twitter_silo = Silo.find_by(name: "Twitter")

    post.syndicates.create(silo: twitter_silo, url: response.url.to_str)
  end

  def self.adjust_tweet_length(tweet)
    return tweet if tweet.length <= MAX_TWEET_LENGTH

    url = "https://#{ENV['SHORT_URL']}/#{post.id}"
    cut_off = MAX_TWEET_LENGTH - 23 - 4 - 10 # extra 10, don't know why it's needed yet

    "#{tweet[0..(cut_off - 1)]}... #{url}"
  end
end
