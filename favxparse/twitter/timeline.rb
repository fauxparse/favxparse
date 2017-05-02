module Favxparse
  module Twitter
    class Timeline
      attr_reader :user, :options

      def initialize(user)
        @user = user
        @options = {
          count: 200,
          trim_user: true,
          exclude_replies: true,
          include_rts: false
        }
      end

      def each
        return enum_for(:each) unless block_given?

        loop do
          tweets = Favxparse::Twitter.client.user_timeline(user, options)

          break if tweets.empty? || tweets.last.id == options[:max_id]

          tweets.shift if options.key?(:max_id)
          tweets.each { |tweet| yield tweet }
          options.update(max_id: tweets.last.id)
        end
      end

      private

      def key
        @key ||= "USER:#{user}"
      end
    end
  end
end
