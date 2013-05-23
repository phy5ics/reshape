require 'spec_helper'

describe Reshape::Client::Orders do
  after(:each) do
    Reshape.reset
  end

  # JSON Tests:

  it "should list orders in json" do
    client = Reshape::Client.new({consumer_token: ENV['SHAPEWAYS_CONSUMER_TOKEN'], consumer_secret: ENV['SHAPEWAYS_CONSUMER_SECRET'], oauth_token: ENV['SHAPEWAYS_OAUTH_TOKEN'], oauth_secret: ENV['SHAPEWAYS_OAUTH_SECRET']})
    # use_vcr_cassette :record => :new_episodes
    
    client.get_cart
    
  end 
  
end