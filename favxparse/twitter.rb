module Favxparse
  module Twitter
    def self.client
      @client ||= ::Twitter::REST::Client.new do |config|
        config.consumer_key        = environment('TWITTER_CONSUMER_KEY')
        config.consumer_secret     = environment('TWITTER_CONSUMER_SECRET')
        config.access_token        = environment('TWITTER_ACCESS_TOKEN')
        config.access_token_secret = environment('TWITTER_ACCESS_SECRET')
      end
    end

    def self.environment(name)
      ENV[name] || raise("missing environment variable: #{name}")
    end
  end
end
