#!/usr/bin/env ruby

require 'bundler/setup'
Bundler.require

require 'dotenv/load'
require 'active_support'
require 'active_support/dependencies'
require 'active_support/core_ext/string'

ActiveSupport::Dependencies.autoload_paths << '.'

module Favxparse
end

Favxparse::Cli.start if __FILE__ == $0
