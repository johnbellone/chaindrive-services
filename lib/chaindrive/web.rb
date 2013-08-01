require 'chaindrive/database'

module Chaindrive
  class Web < Sinatra::Application
    get '/' do
      File.read(File.join(public, 'index.html'))
    end
  end
end
