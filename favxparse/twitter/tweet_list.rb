module Favxparse
  module Twitter
    class TweetList
      attr_reader :user, :page_size

      def initialize(user, page_size: 100)
        @user = user
        @page_size = page_size
      end

      def empty?
        Tweet.connection.llen(key) == 0
      end

      def each
        return enum_for(:each) unless block_given?

        start = 0
        loop do
          ids = Tweet.connection.lrange(key, start, start + page_size - 1)
          break if ids.empty?

          ids.each { |id| yield Tweet.find(user, id) }
          start += page_size
        end
      end

      private

      def key
        @key ||= "USER:#{user}"
      end
    end
  end
end
