# coding: utf-8
require 'chaindrive/api/v1'
require 'chaindrive/webhook/v1'

module Chaindrive
  class Server < Grape::API
    default_format :json
    format :json

    mount Webhook::V1 => '/webhook'
    mount API::V1 => '/api'

    before do
      header 'X-Robots-Tag', 'noindex'
    end

    helpers do
      def compare_etag(respond_etag)
        error!('Not Modified', 304) if request.env['HTTP_ETAG'] == respond_etag.to_s
        header "ETag", respond_etag.to_s
      end

      def logger
        Grape::API.logger
      end
    end
  end
end
