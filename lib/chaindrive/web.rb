# coding: utf-8
require 'sinatra/asset_pipeline'

module Chaindrive
  class Web < Sinatra::Base
    register Sinatra::AssetPipeline

    set :public_folder, File.expand_path('../../public', __FILE__)
  end
end
