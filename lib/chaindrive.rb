require 'sinatra'
require 'grape'
require 'logger'

module Chaindrive
  autoload :Webhook, 'chaindrive/webhook'
  autoload :API, 'chaindrive/api'
  autoload :Gear, 'chaindrive/models/gear'
end
