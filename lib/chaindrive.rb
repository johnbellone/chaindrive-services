require 'sinatra'
require 'grape'
require 'omniauth'
require 'logger'

module Chaindrive
  autoload :Web, 'chaindrive/web'
  autoload :API, 'chaindrive/api'
  autoload :Gear, 'chaindrive/models/gear'
  autoload :User, 'chaindrive/models/user'
end
