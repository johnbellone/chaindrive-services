# coding: utf-8
$:.unshift('lib').uniq!

# Default some values that we would normally expect at runtime.
ENV['RACK_ENV'] ||= 'test'
ENV['RACK_SESSION_COOKIE_SECRET'] ||= ENV['RACK_ENV']
ENV['DATABASE_URL'] ||= "sqlite://tmp/#{ENV['RACK_ENV']}.db"
ENV['RACK_CACHE_META_STORE'] ||= 'tmp:/meta'
ENV['RACK_CACHE_ENTITY_STORE'] ||= 'tmp:/entity'

require 'rubygems'
require 'bundler/setup'
Bundler.require :default
