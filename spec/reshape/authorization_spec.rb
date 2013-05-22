require 'spec_helper'

describe Reshape::Client do

  let(:client) do
    Reshape::Client.new({consumer_token: ENV['SHAPEWAYS_CONSUMER_TOKEN'], consumer_secret: ENV['SHAPEWAYS_CONSUMER_SECRET']})
  end

  describe "consumer" do
    describe "default oauth options" do
      
      let(:consumer) { client.consumer }

      it "should return a configured OAuth consumer" do
        consumer.site.should == 'http://api.shapeways.com/'
        consumer.request_token_url.should == 'http://api.shapeways.com/oauth1/request_token/v1'
        consumer.access_token_url.should == 'http://api.shapeways.com/oauth1/access_token/v1'
      end
    end
    
  end

  describe "request_token" do
    describe "with default options" do
      use_vcr_cassette :record => :new_episodes
      
      it "should return a valid request token" do
        request_token = client.request_token
        request_token.should be_a_kind_of OAuth::RequestToken
        a_request(:get, "http://api.shapeways.com/oauth1/request_token/v1").should have_been_made.once
      end
    end

  end

  describe "authorize_from_request" do
    let(:access_token) do
      # if you remove the related casssette you will need to do the following
      # authorize_from_request request manually
      #
      # request_token = client.request_token
      # puts "#{request_token.inspect}"
      # puts "token: #{request_token.token} - secret #{request_token.secret}"
      # puts "auth url: #{request_token.authorize_url}"
      # raise 'keep note of the token and secret'
      
      # client.authorize_from_request(, '849210cd1142b55fd801dbc62e782edc87264e37', 'c20b027a5d659c4923252d41dada93990654a79b')
      # client.authorize_from_request('dummy-token', 'dummy-secret', 'dummy-pin')
      
      # client.authorize_from_request('a24aaa5c807bc2b0bf2eab0eeecd27a66dc6b6a5', 'c87395322843c4ca1cd18680f6c4d8fb801c2a6d', '5ef43b')
      
      client.authorize_from_request('dummy-token', 'dummy-secret', 'dummy-pin')
    end

    use_vcr_cassette :record => :new_episodes, :match_requests_on => [:uri, :method]

    it "should return a valid access token" do
      access_token.should be_a_kind_of Array
      access_token[0].should be_a_kind_of String
      access_token[1].should be_a_kind_of String

      a_request(:get, "http://api.shapeways.com/oauth1/access_token/v1").should have_been_made.once
    end
  end

  describe "access_token" do
    let(:access_token) do
      client.authorize_from_access('dummy-token', 'dummy-secret')
      client.access_token
    end

    it "should return a valid auth token" do
      access_token.should be_a_kind_of OAuth::AccessToken
      access_token.token.should be_a_kind_of String
    end
  end

  describe "authorize_from_access" do
    
    let(:auth_token) do
      client.authorize_from_access('dummy-token', 'dummy-secret')
    end

    it "should return a valid auth token" do
      auth_token.should be_a_kind_of Array
      auth_token[0].should be_a_kind_of String
      auth_token[1].should be_a_kind_of String
    end
  end

end
