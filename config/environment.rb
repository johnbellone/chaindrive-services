$:.unshift('lib').uniq!

ENV['RACK_ENV'] ||= 'test'

require 'rubygems'
require 'bundler/setup'
Bundler.require :default, ENV['RACK_ENV']

require 'chaindrive'
