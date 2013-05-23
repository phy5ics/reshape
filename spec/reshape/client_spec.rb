require 'spec_helper'

describe Reshape::Client do
  it 'should instantiate with consumer key and consumer secret' do
    proc {
      Reshape::Client.new({consumer_token: ENV['SHAPEWAYS_CONSUMER_TOKEN'], consumer_secret: ENV['SHAPEWAYS_CONSUMER_SECRET'], oauth_token: ENV['SHAPEWAYS_OAUTH_TOKEN'], oauth_secret: ENV['SHAPEWAYS_OAUTH_SECRET']})
    }.should_not raise_exception
  end

  describe "api_endpoint" do
    after(:each) do
      Reshape.reset
    end

    it "should default to http://api.shapeways.com/" do
      client = Reshape::Client.new
      client.api_endpoint.should == 'http://api.shapeways.com/'
    end

    it "should be set " do
      Reshape.api_endpoint = 'http://foo.dev'
      client = Reshape::Client.new
      client.api_endpoint.should == 'http://foo.dev/'
    end
  end
  
  describe "web_endpoint" do
    after(:each) do
      Reshape.reset
    end

    it "should default to http://www.shapeways.com/" do
      client = Reshape::Client.new
      client.web_endpoint.should == 'http://www.shapeways.com/'
    end

    it "should be set " do
      Reshape.web_endpoint = 'http://foo.dev'
      client = Reshape::Client.new
      client.web_endpoint.should == 'http://foo.dev/'
    end
  end
  
end