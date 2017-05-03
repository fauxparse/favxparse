#!/usr/bin/env ruby

require 'bundler/setup'
require 'dotenv/load'
require 'active_support'
require 'active_support/dependencies'
require 'active_support/core_ext/string'
require 'pry'
require 'redis'
require 'twitter'

ActiveSupport::Dependencies.autoload_paths << '.'

module Favxparse
end

Favxparse::Cli.start if __FILE__ == $0
