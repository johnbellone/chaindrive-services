module Chaindrive
  class API < Grape::API
    version 'v1'

    # Provide authentication with GitHub so that we can properly use the API there
    # once someone adds a Gear to the registry. 
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
