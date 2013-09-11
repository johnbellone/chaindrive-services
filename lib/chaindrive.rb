# coding: utf-8
require 'chaindrive/webhook'
require 'chaindrive/api'
require 'chaindrive/model/gear'
require 'chaindrive/model/gear_release'
require 'chaindrive/worker/gear_release_event'

module Chaindrive
  def self.development?
    ENV['RACK_ENV'] == 'development'
  end

  def self.session_cookie
    ENV['RACK_SESSION_COOKIE_SECRET']
  end

  def self.cache_entitystore
    ENV['RACK_CACHE_ENTITY_STORE']
  end

  def self.cache_metastore
    ENV['RACK_CACHE_META_STORE']
  end
end
