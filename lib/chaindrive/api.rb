require 'chaindrive/api/v1'

module Chaindrive
  class API < Grape::API
    format :json

    # Define any helper methods that we want to make available inside of any endpoint.
    helpers do
      def compare_etag(respond_etag)
        error!("Not Modified", 304) if request.env['HTTP_ETAG'] == respond_etag.to_s
        header "ETag", respond_etag.to_s
      end
    end

    # Setup the middleware for Rack::Cache so that we can save a little bit on the
    # number of database hits.
    use Rack::Cache,
      verbose: true,
      metastore: 'tmp/meta',
      entitystore: 'tmp/body',
      allow_reload: true
    
    # Provide authentication with GitHub so that we can properly use the API there
    # once someone adds a Gear to the registry. 
    use ::OmniAuth::Builder do 
      provider :developer unless ENV['RACK_ENV'] == 'production'
      provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
    end

    # Mixin all of the versions of the API.
    mount Chaindrive::APIv1
  end
end
