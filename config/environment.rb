$:.unshift('lib').uniq!

# Default some values that we would normally expect at runtime.
ENV['RACK_ENV'] ||= 'test'
ENV['RACK_SESSION_COOKIE_SECRET'] ||= 'test'
ENV['DATABASE_URL'] ||= "sqlite://tmp/#{ENV['RACK_ENV']}.db"

require 'rubygems'
require 'bundler/setup'
Bundler.require :default, ENV['RACK_ENV']

require 'chaindrive'
require 'rack'
