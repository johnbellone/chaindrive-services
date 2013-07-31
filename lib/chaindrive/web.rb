require 'sinatra'
require 'chaindrive/database'
require 'chaindrive/gear'

module Chaindrive
  class Web < Sinatra::Application
    get '/' do
      Gear.all
    end
  end
end
