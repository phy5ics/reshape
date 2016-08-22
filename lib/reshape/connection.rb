require 'faraday_middleware'
require 'faraday/response/raise_reshape_api_error'

module Reshape
  module Connection
    private
    def oauth_data
      {
        consumer_key: @consumer_token,
        consumer_secret: @consumer_secret,
        token: @oauth_token,
        token_secret: @oauth_secret
      }
    end
    
    def connection(raw=false, force_urlencoded=false)
      url = "#{Reshape.api_endpoint}"


      options = {
        url: url,
        proxy: proxy,
        ssl: { verify: false },
      }

      connection = Faraday.new(options) do |builder|
        builder.use Faraday::Response::RaiseReshapeApiError
        builder.request :json
        builder.request :oauth, oauth_data

        #set the connection options passed in the constructor
        self.connection_options.each{ |op,v| builder.options[op] = v }

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
