module Favxparse
  module Twitter
    class UpdateCache
      def initialize(source = ENV['TWITTER_SOURCE'])
        @source = source || raise('no source account specified')
      end

      def call
        timeline.each do |tweet|
          break if Tweet.exists?(source, tweet.id)
          text = tweet.attrs[:full_text] || tweet.attrs[:text]
          Tweet.create(user: source, id: tweet.id, text: text)
        end
      end

      private

      attr_accessor :source

      def timeline
        @timeline ||= Timeline.new(source)
      end
    end
  end
end
