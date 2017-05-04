module Favxparse
  module Twitter
    class UpdateCache
      def initialize(source = ENV['TWITTER_SOURCE'], force: false)
        @source = source || raise('no source account specified')
        @force = force
      end

      def call
        timeline.each do |tweet|
          break if !force && Tweet.exists?(source, tweet.id)
          text = tweet.attrs[:full_text] || tweet.attrs[:text]
          Tweet.create(user: source, id: tweet.id, text: text)
        end
      end

      private

      attr_accessor :source, :force

      def timeline
        @timeline ||= Timeline.new(source)
      end
    end
  end
end
