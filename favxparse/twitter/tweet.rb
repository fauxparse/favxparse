module Favxparse
  module Twitter
    class Tweet
      def self.create(user:, id:, text:)
        connection.set(id, text)
        connection.rpush("USER:#{user}", id)
      end

      def self.exists?(id)
        connection.exists(id)
      end

      def self.find(id)
        connection.get(id)
      end

      def self.connection
        Favxparse::Redis.client
      end
    end
  end
end
