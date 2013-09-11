# coding: utf-8
module Chaindrive::Worker
  class GearReleaseEvent 
    include Sidekiq::Worker

    def perform(payload)
      logger.debug {"Payload: #{payload.inspect}"}
      repository = payload['repository']

      begin
        ref = payload['ref'].match(/refs\/tags\/v?(\d(\.\d){,3})/)[0]
        
        # If the package already exists then we just want to update
        # the time and possibly the description fields. We need the
        # reference to create the release.
        gear = Gear.first(name: repository['name']).eager(:gear_releases)
        gear ||= Gear.create do |g|
          g.name = repository['name']
          g.owner = repository['owner']['name']
          g.url = repository['url']
          g.created_at = repository['created_at']
        end

        logger.debug {'Gear: '+gear.inspect}
          
        gear.description = repository['description']
        gear.updated_at = repository['pushed_at']
        gear.save

        # Cleanup the reference and first see if the release already
        # exists. This may just need to be updated (time) but more
        # likely we are going to create a new record.
        ref.slice!(0,1) if ref.chr.downcase == 'v'
        release = gear.gear_releases.find(version: ref)
        release ||= GearRelease.create do |gr|
          gr.version = ref
          gr.gear = gear
          gr.created_at = repository['pushed_at']
        end

        logger.debug {'Release: '+release.inspect}

        release.updated_at = repository['pushed_at']
        release.save
      rescue Exception => e
        logger.error {'Exception: '+e.message}
        raise
      end
    end

  end
end
