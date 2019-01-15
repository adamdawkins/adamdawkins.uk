TwitterClient = Twitter::REST::Client.new do |config|
  config.consumer_key = Rails.application.credentials.twitter[:consumer_key]
  config.consumer_secret = Rails.application.credentials.twitter[:consumer_secret]
  config.access_token = Rails.application.credentials.twitter[:access_token]
  config.access_token_secret = Rails.application.credentials.twitter[:access_token_secret]
end

class TwitterService
  def self.post(note)  
    res = TwitterClient.update(note)
    puts "response from twitter"
    pp res.url.to_str
  end
end
