module Chaindrive
  class Webhook < Grape::API
    namespace :webhook do
      namespace :gears do
        desc "Webhook for GitHub push-hook requests."
        post do
          error!('Bad Request', 400) unless params[:payload]
          payload = JSON.parse(params[:payload])          

          repository = payload[:repository]         
          error!('Bad Request', 400) unless repository
          error!('Forbidden', 403) if repository[:private]          

          # Only do something if the ref being pushed is a tag.
          ref = payload[:ref].match(/refs\/tags\/v?(\d(\.\d){,3})/)[0]
          error!('OK', 200) unless ref          

          # If the package already exists then we just want to update the time and
          # possibly the description fields. We need the reference to create the release.
          gear = Gear.first(name: repository[:name]).eager(:gear_releases)
          gear = Gear.create do |g|
            g.name = repository[:name]
            g.owner = repository[:owner][:name]
            g.url = repository[:url]
            g.created_at = Time.now
          end unless gear
        
          gear.description = repository[:description]
          gear.updated_at = repository[:pushed_at]
          gear.save

          # Cleanup the reference and first see if the release already exists. This may
          # just need to be updated (time) but more likely we are going to create one.
          ref.slice!(0,1) if ref.chr.downcase == 'v'
          release = gear.gear_releases.find(version: ref)
          release = GearRelease.create do |gr|
            gr.version = ref
            gr.gear = gear
            gr.created_at = Time.now
          end unless release

          gr.updated_at = repository[:pushed_at]
          gr.save
        end
      end
    end
  end
end
