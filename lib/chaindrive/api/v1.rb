module Chaindrive
  class APIv1 < Grape::API
    version 'v1'

    namespace :webhook do
      namespace :gears do
        desc "Webhook for GitHub push-hook requests."
        post do
          error!('Bad Request', 400) unless params[:payload]
          event = params[:payload]
        end
      end
    end

    namespace :users do
      get do
        present User.all
      end

      get ':id' do
        compare_etag(Time.now.day)
        present User.first(:name => params[:id])
      end

      get ':id/gears' do
        compare_etag(Time.now.day)
        present User.first(:name => params[:id]).gears.all
      end
    end
    
    namespace :gears do
      desc "Return all gears inside the registry."
      get do
        compare_etag(Time.now.day)
        present Gear.all
      end

      desc "Return the Gear with specified `id`."
      get ':id' do
        compare_etag(Time.now.day)
        Gear.def_dataset_method(:by_created_at){order(:created_at)}
        present Gear.by_created_at.first(:name => params[:id])
      end

      get ':id/:version' do
        compare_etag(Time.now.day)
        # TODO: Do we actually want to allow a fuzzy version, e.g. ~> 0.1, to return
        # all of the versions that match this value? In that case the query would be:
        # Gear.by_created_at.where(:name => params[:id], Sequel.like(:version, "#{params[:version]}%"))
        Gear.def_dataset_method(:by_created_at){order(:created_at)}
        present Gear.by_created_at.where(:name => params[:id], :version => params[:version])
      end

      post do
        # authenticate!
        error!('Bad Request', 400) unless params[:id]
        error!('Found', 302) if Gear.exists?(params[:id])
      end

    end
  end
end
