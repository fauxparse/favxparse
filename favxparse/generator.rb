module Favxparse
  class Generator
    def initialize(user)
      @dictionary = Dictionary.new(user)
    end

    def generate
      loop do
        tweet = raw.join
        return tweet if valid?(tweet)
      end
    end

    private

    attr_accessor :dictionary, :formatter

    def valid?(tweet)
      !tweet.empty? &&
        tweet.length < 140 &&
        !Favxparse::Twitter::Tweet.looks_like_original?(dictionary.user, tweet)
    end

    def raw
      TokenList.new.tap do |tokens|
        context = dictionary.initial_context
        loop do
          token = dictionary.choose(context)
          tokens << token
          break if Token::End === token
        end
      end
    end
  end
end
