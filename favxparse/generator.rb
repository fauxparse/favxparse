module Favxparse
  class Generator
    def initialize(user, &block)
      @formatter = Formatter.new
      @dictionary = Dictionary.new(user, formatter)
      @validator = block || ->(tweet) { true }
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
        @validator.call(tweet)
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
