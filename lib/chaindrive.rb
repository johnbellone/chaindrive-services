require 'sinatra'
require 'grape'
require 'omniauth'
require 'logger'

module Chaindrive
  autoload :Webhook, 'chaindrive/webhook'
  autoload :API, 'chaindrive/api'
  autoload :DB, 'chaindrive/database'
  autoload :Gear, 'chaindrive/models/gear'
end
