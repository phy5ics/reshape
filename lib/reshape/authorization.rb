require 'oauth'

module Reshape
  module Authorization
    
    def consumer
      @consumer ||= ::OAuth::Consumer.new(@consumer_token, @consumer_secret, parse_oauth_options)
    end

    # Note: If using oauth with a web app, be sure to provide :oauth_callback.
    # Options:
    #   :oauth_callback => String, url that Shapeways should redirect to
    def request_token(options={})
      @request_token ||= consumer.get_request_token(options)
    end

    # For web apps use params[:oauth_verifier], for desktop apps,
    # use the verifier is the pin that Shapeways gives users.
    def authorize_from_request(request_token, request_secret, verifier_or_pin)
      puts "authorize_from_request REQUEST_TOKEN = #{request_token}"
      puts "authorize_from_request GEM REQUEST_SECRET = #{request_secret}"
      puts "authorize_from_request GEM VERIFIER = #{verifier_or_pin}"
      
      request_token = ::OAuth::RequestToken.new(consumer, request_token, request_secret)
      access_token = request_token.get_access_token(:oauth_verifier => verifier_or_pin)
      @auth_token, @auth_secret = access_token.token, access_token.secret
    end

    def access_token
      puts "access_token CONSUMER = #{consumer}"
      puts "access_token AUTH_TOKEN = #{@auth_token}"
      puts "access_token AUTH_SECRET = #{@auth_secret}"
      @access_token ||= ::OAuth::AccessToken.new(consumer, @auth_token, @auth_secret)
    end

    def authorize_from_access(atoken, asecret)
      puts "authorize_from_access ATOKEN = #{atoken}"
      puts "authorize_from_access ASECRET = #{asecret}"
      @auth_token, @auth_secret = atoken, asecret
    end

    private
    def parse_oauth_options
      {
        :request_token_url => "#{api_endpoint}#{request_token_path}#{api_version}",
        :access_token_url => "#{api_endpoint}#{access_token_path}#{api_version}",
        :authorize_url => "#{api_endpoint}#{authorize_path}#{api_version}",
        :site => "#{@api_endpoint}",
        :scheme => :header,
        :http_method => :get,
        :proxy => 'http://127.0.0.1:8888'
      }
    end

  end
end
