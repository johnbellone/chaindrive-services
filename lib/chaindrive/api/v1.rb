# coding: utf-8
module Chaindrive
  class APIv1 < Grape::API
    version 'v1', using: :path

    namespace :gears do
      desc "Return all gears inside the registry."
      get do
        compare_etag(Time.now.day)
        present Gear.all
      end

      desc "Return the Gear with specified `id`."
      get ':id' do
        compare_etag(Time.now.day)

        Gear.def_dataset_method(:by_created_at){reverse_order(:created_at)}
        criteria = {name: params['id']}
        gear = Gear.by_created_at.first(criteria)

        error!('Not Found', 404) unless gear

        gear.hit!
        present gear
      end

      get ':id/:version' do
        compare_etag(Time.now.day)

        version = params['version']
        version.slice!(0,1) if version.chr.downcase == 'v'

        criteria = {name: params['id'], version: params['version']}
        Gear.def_dataset_method(:by_created_at){reverse_order(:created_at)}
        gear = Gear.by_created_at.where(criteria)

        error!('Not Found', 404) unless gear

        gear.hit!
        present gear
      end
    end

  end
end
