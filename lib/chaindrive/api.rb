# coding: utf-8
require 'chaindrive/api/v1'

module Chaindrive
  class API < Grape::API
    default_format :json
    format :json

    before do
      header 'X-Robots-Tag', 'noindex'
    end

    # Define any helper methods that we want to make available inside of any
    # endpoint.
    helpers do
      def compare_etag(respond_etag)
        error!('Not Modified', 304) if request.env['HTTP_ETAG'] == respond_etag.to_s
        header "ETag", respond_etag.to_s
      end

      def logger
        Grape::API.logger
      end
    end

    # Mixin all of the versions of the API.
    mount Chaindrive::API::V1
  end
end
