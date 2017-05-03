module Favxparse
  module Twitter
    class UpdateCache
      def initialize(source = ENV['TWITTER_SOURCE'])
        @source = source || raise('no source account specified')
      end

      def call
        timeline.each do |tweet|
          break if Tweet.exists?(source, tweet.id)
          Tweet.create(user: source, id: tweet.id, text: tweet.text)
        end
      end

      private

      attr_accessor :source, :options

      def timeline
        @timeline ||= Timeline.new(source)
      end
    end
  end
end
