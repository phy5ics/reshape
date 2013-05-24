require 'spec_helper'

describe Reshape::Client::Materials do
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

  it "should list materials in json" do
    VCR.use_cassette('materials') do
      response = client.materials
      response.should be_an_instance_of(Hashie::Mash)
      response.result.should == 'success'
    end
  end 
  
  it "should add an order to the cart in json" do
    VCR.use_cassette('material') do
      response = client.material(77)
      response.should be_an_instance_of(Hashie::Mash)
      response.result.should == 'success'
    end
  end
  
end