#!/usr/bin/env ruby

require 'bundler/setup'
Bundler.require

require 'dotenv/load'
require 'active_support'
require 'active_support/dependencies'

ActiveSupport::Dependencies.autoload_paths << '.'

module Favxparse
end
