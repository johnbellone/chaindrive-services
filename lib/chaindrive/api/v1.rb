module Chaindrive
  class APIv1 < Grape::API
    version 'v1'
    
    namespace :gears do
      desc "Return all gears inside the registry."
      get do
        compare_etag(Time.now.day)
        Gear.all
      end

      params do
        requires :id, type: String, desc: "Gear name."
      end

      route_param :id do
        desc "Return the Gear with specified `id`."
        get do
          compare_etag(Time.now.day)
          Gear.where(:name => params[:id], :status => true).order(:created_at).limit(1)  
        end
      end

      params do
        requires :id, type: String, desc: "Gear name."
        requires :version, type: String, desc: "Gear version."
      end

      get ':id/version/:version' do
        compare_etag(Time.now.day)
        Gear.where(:name => params[:id], :version => params[:version], :status => true)
      end

    end
  end
end
