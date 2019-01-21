TwitterClient = Twitter::REST::Client.new do |config|
  config.consumer_key = Rails.application.credentials.twitter[:consumer_key]
  config.consumer_secret = Rails.application.credentials.twitter[:consumer_secret]
  config.access_token = Rails.application.credentials.twitter[:access_token]
  config.access_token_secret = Rails.application.credentials.twitter[:access_token_secret]
end

MAX_TWEET_LENGTH = 280

class TwitterService
  def self.post(post)
    tweet = post.content
    tweet.gsub!('*', '＊')
    if (tweet.length > MAX_TWEET_LENGTH)
      pp "too long"
      pp post.id
      url = "#{ENV['SHORT_URL']}/#{post.id}"
      pp url
      cut_off = MAX_TWEET_LENGTH - url.length - 4 # the 4 is 3 elipses dots + a space or return
      tweet = "#{tweet[0..cut_off]}...\r#{url}"
    end
    response = TwitterClient.update(tweet)

    twitter_silo = Silo.find_by(name: "Twitter")

    post.syndicates.create(silo: twitter_silo, url: response.url.to_str)
  end
end
