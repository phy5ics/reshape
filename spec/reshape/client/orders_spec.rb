require 'spec_helper'

describe Reshape::Client::Orders do
  let(:client) do
    Reshape::Client.new({
      consumer_token: ENV['SHAPEWAYS_CONSUMER_TOKEN'], 
      consumer_secret: ENV['SHAPEWAYS_CONSUMER_SECRET'], 
      oauth_token: ENV['SHAPEWAYS_OAUTH_TOKEN'], 
      oauth_secret: ENV['SHAPEWAYS_OAUTH_SECRET'], 
      proxy: 'http://localhost:8888'
    })
  end
  
  after(:each) do
    Reshape.reset
  end

  it "should list cart orders in json" do
    VCR.use_cassette('cart') do
      response = client.cart
      response.should be_an_instance_of(Hashie::Mash)
      response.result.should == 'success'
    end
  end 
  
  it "should add an order to the cart in json" do
    VCR.use_cassette('add_to_cart') do
      response = client.add_to_cart(212594, 77, 1)
      response.should be_an_instance_of(Hashie::Mash)
      response.result.should == 'success'
    end
  end
  
end