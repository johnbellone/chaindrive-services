require 'grape'
require 'chaindrive/database'

module Chaindrive
  class API < Grape::API
    version 'v1'

    use Rack::Session::Cookie
    use Omniauth::Builder do 
      provider :developer unless ENV['RACK_ENV'] == 'production'
      provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
    end

    namespace :gears do
      get do
        Gear.all
      end

      get ':id' do
        Gear.where(:name => params[:id], :status => true).order(:created_at).limit(1)
      end

      get ':id/version/:version' do
        Gear.where(:name => params[:id], :version => params[:version], :status => true)
      end
    end

  end
end
