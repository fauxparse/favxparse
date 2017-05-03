require 'sinatra'
require_relative './favxparse'

user = ENV['TWITTER_SOURCE']
generator = Favxparse::Generator.new(user)

get '/' do
  @user = user
  @tweet = generator.generate
  erb :tweet
end
