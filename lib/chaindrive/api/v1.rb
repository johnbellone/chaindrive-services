module Chaindrive
  class APIv1 < Grape::API
    version 'v1'
    
    namespace :gears do
      desc "Return all gears inside the registry."
      get do
        compare_etag(Time.now.day)
        Gear.all
      end

      desc "Return the Gear with specified `id`."
      get ':id' do
        compare_etag(Time.now.day)
        Gear.where(:name => params[:id], :status => true).order(:created_at).limit(1).first  
      end

      get ':id/:version' do
        compare_etag(Time.now.day)
        Gear.where(:name => params[:id], :version => params[:version], :status => true).limit(1).first
      end

    end
  end
end
