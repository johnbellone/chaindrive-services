# coding: utf-8
module Chaindrive
  class Webhook < Grape::API
    namespace :webhook do
      desc 'Webhook for GitHub API events'
      namespace :github do
        event = headers['X-GitHub-Event']
        delivery_guid = headers['X-GitHub-Delivery']
        payload = MultiJson.load(params['payload'], symbolize_keys: true)

        case event.to_s
        when 'push'
          error!('Bad Request', 400) unless payload['repository']

          # TODO: There is definitely going to be a need for this in the
          # future. But for now let's just respond back as a failure.
          error!('Forbidden', 403) if payload['repository']['private']
          
          Worker::GearReleaseEvent.perform_async(payload)
        else
          error!('Not Implemented', 500)
        end
      end
    end
  end
end

