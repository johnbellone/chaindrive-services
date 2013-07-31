module Chaindrive
  class APIv1 < Grape::API
    version 'v1'
    
    namespace :gears do
      get do
        compare_etag(Time.now.day)
        Gear.all
      end

      get ':id' do
        compare_etag(Time.now.day)
        Gear.where(:name => params[:id], :status => true).order(:created_at).limit(1)
      end

      get ':id/version/:version' do
        compare_etag(Time.now.day)
        Gear.where(:name => params[:id], :version => params[:version], :status => true)
      end
    end
  end
end
