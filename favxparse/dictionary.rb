module Favxparse
  class Dictionary
    attr_reader :user, :formatter, :depth

    def initialize(user, depth: 2)
      @user = user
      @depth = depth
      @training = {}
      build_from_tweets
    end

    def choose(context)
      (training[context] || [Token::End.new]).sample.tap do |token|
        rotate_context(context, token.to_s)
      end
    end

    def initial_context
      [Token::Start.new.to_s] * depth
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
      (tokens + [Token::End.new]).each.with_object(initial_context) do |token, context|
        add(context, token)
      end
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
