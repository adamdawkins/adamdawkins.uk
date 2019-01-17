TwitterClient = Twitter::REST::Client.new do |config|
  config.consumer_key = Rails.application.credentials.twitter[:consumer_key]
  config.consumer_secret = Rails.application.credentials.twitter[:consumer_secret]
  config.access_token = Rails.application.credentials.twitter[:access_token]
  config.access_token_secret = Rails.application.credentials.twitter[:access_token_secret]
end

class TwitterService
  def self.post(post)  
    tweet = post.content
    tweet.gsub('*', '＊')
    response = TwitterClient.update(tweet)

    twitter_silo = Silo.find_by(name: "Twitter")

    post.syndicates.create(silo: twitter_silo, url: response.url.to_str)
  end
end
