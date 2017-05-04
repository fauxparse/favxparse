module Favxparse
  class Dictionary
    attr_reader :user, :formatter, :depth

    def initialize(user, formatter = Formatter.new, depth: 2)
      @user = user
      @depth = depth
      @training = {}
      @formatter = formatter
      build_from_tweets
    end

    def choose(context)
      (training[context] || [Token::END_TEXT]).sample.tap do |token|
        rotate_context(context, token.to_s)
      end
    end

    def initial_context
      [Token::START_TEXT] * depth
    end

    private

    attr_reader :training, :formatter

    def build_from_tweets
      Favxparse::Twitter::UpdateCache.new(user).call if tweets.empty?

      @learning = {}

      tweets.each do |tweet|
        learn(Tokeniser.new(tweet.text).tokens)
      end
    end

    def tweets
      @tweets ||= Favxparse::Twitter::TweetList.new(user)
    end

    def learn(tokens)
      (tokens + [Token::END_TEXT]).each.with_object(initial_context) do |token, context|
        add(context, token)
      end
      formatter.learn(tokens)
      self
    end

    def add(context, token)
      (training[context[0..-1]] ||= []).push(token)
      rotate_context(context, token.to_s)
    end

    def rotate_context(context, token)
      token = token.strip if token.respond_to?(:strip) && !token.strip.empty?
      context.tap(&:shift).push(token.downcase)
    end
  end
end
