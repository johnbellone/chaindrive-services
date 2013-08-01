module Chaindrive
  class Auth < Grape::API
    prefix 'auth'
    
    # Support HTTP verbs for OmniAuth provider callbacks.
    %w{get post}.each do |verb|
      send(verb, ':provider/callback') do
        logger.info env['omniauth.auth'].inspect
      end
    end
  end
end
