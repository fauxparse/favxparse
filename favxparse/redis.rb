module Favxparse
  module Redis
    def self.client
      @client ||= ::Redis.new(url: ENV['REDIS_URL'])
    end
  end
end
