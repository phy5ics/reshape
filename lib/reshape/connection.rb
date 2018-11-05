require 'faraday_middleware'
require 'faraday/response/raise_reshape_api_error'

module Reshape
  module Connection
    private
    def oauth_data
      {
        oauth_token: @oauth_token,
        token_type: :bearer
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
        #builder.request :oauth2, oauth_data

        builder.request :oauth2, @oauth_token, token_type: :bearer

        builder.response :logger

        #set the connection options passed in the constructor
        # https://github.com/lostisland/faraday/issues/417
        # http://stackoverflow.com/questions/8098584/faraday-timeout
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
