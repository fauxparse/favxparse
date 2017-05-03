module Favxparse
  module Twitter
    class Tweet
      attr_reader :user, :text, :id

      def initialize(user:, text:, id:)
        @user = user
        @text = text
        @id = id
      end

      def save
        return false unless id
        key = "TWEET:#{user}:#{id}"
        connection.set(key, text)
        connection.rpush("USER:#{user}", id)
        connection.hset("HASH:#{user}", digest, 1)
      end

      def digest
        Favxparse::Twitter::Digest.new(text).to_s
      end

      def self.create(user:, text:, id: nil)
        new(user: user, text: text, id: id).save
      end

      def self.exists?(user, id)
        connection.exists("TWEET:#{user}:#{id}")
      end

      def self.find(user, id)
        text = connection.get("TWEET:#{user}:#{id}")
        return nil unless text
        new(user: user, id: id, text: text)
      end

      def self.connection
        Favxparse::Redis.client
      end

      def self.looks_like_original?(user, text)
        digest = Favxparse::Twitter::Digest.new(text).to_s
        connection.hexists("HASH:#{user}", digest)
      end

      private

      def connection
        self.class.connection
      end
    end
  end
end
