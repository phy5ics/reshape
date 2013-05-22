require 'faraday_middleware'

module Reshape
  module Authorization
  
    def consumer
      url = "#{Reshape.api_endpoint}"

      options = {
        url: url
      }

      connection ||= Faraday.new(options) do |builder|
        builder.use Faraday::Request::OAuth, {
          :consumer_key => @consumer_key,
          :consumer_secret => @consumer_secret,
          :token => @atoken,
          :token_secret => @asecret
        }
        
        builder.adapter *adapter
      end
      connection
    end
    
    def request_token(options={})
      # consumer.http.set_debug_output($stdout)
      @request_token ||= consumer.get_request_token(options)
    end
  
  end
end
