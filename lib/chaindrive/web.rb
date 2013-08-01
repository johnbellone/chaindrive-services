require 'chaindrive/database'

module Chaindrive
  class Web < Sinatra::Application
    get '/' do
      Gear.all
    end
  end
end
