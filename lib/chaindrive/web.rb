# coding: utf-8
require 'sinatra/asset_pipeline'

module Chaindrive
  class Web < Sinatra::Base
    set :sprockets, Sprockets::Environment.new(root)
    set :public_folder, File.expand_path('../../public', __FILE__)

    set :precompile, [ /\w+\.(?!js|css).+/, /application.(css|js)$/ ]
    set :assets_prefix, '/assets'
    set :digest_assets, false
    set :assets_path, File.join(public_folder, assets_prefix)

    register Sinatra::AssetPipeline

    configure do
      sprockets.append_path File.join(root, 'assets/styles')
      sprockets.append_path File.join(root, 'assets/scripts')
      sprockets.append_path File.join(root, 'assets/images')

      Sprockets::Helpers.configure do |config|
        config.environment = sprockets
        config.prefix = assets_prefix
        config.digest = digest_assets
        config.public_path = public_folder
      end
    end

    helpers do
      include Sprockets::Helpers
    end

  end
end
