require 'thor'

module Favxparse
  class Cli < Thor
    desc 'tweet', 'Send a tweet'
    method_option :user,
      aliases: '-u',
      desc: 'User to impersonate',
      default: ENV['TWITTER_SOURCE']
    method_options dry_run: false
    def tweet
      generator = Generator.new(options[:user])
      tweet = generator.generate
      puts "Tweeting to #{ENV['TWITTER_ACCOUNT']}:\n#{tweet}"
      Favxparse::Twitter.client.update(tweet) unless options[:dry_run]
    end

    desc 'update', 'Update the tweet cache'
    method_option :user,
      aliases: '-u',
      desc: 'User to impersonate',
      default: ENV['TWITTER_SOURCE']
    method_options force: false
    def update
      puts "Updating cache for #{options[:user]}..."
      Favxparse::Twitter::UpdateCache.new(
        options[:user], force: options[:force]
      ).call
    end
  end
end
