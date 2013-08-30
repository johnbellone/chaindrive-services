require 'sinatra'
require 'grape'
require 'logger'

module Chaindrive
  autoload :Webhook, 'chaindrive/webhook'
  autoload :API, 'chaindrive/api'
  autoload :Gear, 'chaindrive/models/gear'

  def self.development?
    ENV['RACK_ENV'] == 'development'
  end

  def self.session_cookie
    ENV['RACK_SESSION_COOKIE_SECRET']
  end
end
