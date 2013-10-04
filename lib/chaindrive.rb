# coding: utf-8
require 'chaindrive/webhook'
require 'chaindrive/api'
require 'chaindrive/gear'
require 'chaindrive/gear_release'
require 'chaindrive/worker/gear_release_event'

module Chaindrive
  def development?
    ENV['RACK_ENV'] == 'development'
  end

  def session_cookie
    ENV['RACK_SESSION_COOKIE_SECRET']
  end

  def cache_entitystore
    ENV['RACK_CACHE_ENTITY_STORE']
  end

  def cache_metastore
    ENV['RACK_CACHE_META_STORE']
  end
end
