require 'faraday_middleware'
require 'faraday/response/raise_reshape_api_error'

module Reshape
  module Connection
    private

    def connection(raw=false, force_urlencoded=false)
      # url = "#{Reshape.api_endpoint}#{Reshape.api_version}"
      url = "#{Reshape.api_endpoint}"

      options = {
        url: url
      }
      
      connection = Faraday.new(options) do |builder|
        builder.use Faraday::Response::RaiseReshapeApiError
        unless raw
          builder.use FaradayMiddleware::Mashify
          builder.use FaradayMiddleware::ParseJson
        end
        builder.adapter *adapter
      end
      connection
    end
  end
end