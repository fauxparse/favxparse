module Favxparse
  class Generator
    def initialize(user)
      @formatter = Formatter.new
      @dictionary = Dictionary.new(user, formatter)
    end

    def generate
      loop do
        tweet = formatter.format(raw)
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
      [].tap do |tokens|
        context = dictionary.initial_context
        loop do
          token = dictionary.choose(context)
          break if token == Token::END_TEXT
          tokens << token
        end
      end
    end
  end
end
