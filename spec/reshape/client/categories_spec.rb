require 'spec_helper'

describe Reshape::Client::Categories do
  let(:client) do
    shapeways_client
  end
  
  after(:each) do
    shapeways_client.reset
  end

  it "should list printers in json" do
    VCR.use_cassette('categories') do
      response = client.categories
      response.should be_an_instance_of(Hashie::Mash)
      response.result.should == 'success'
    end
  end 
  
  it "should return specific printer info in json" do
    VCR.use_cassette('category') do
      response = client.category(100)
      response.should be_an_instance_of(Hashie::Mash)
      response.result.should == 'success'
      response.title.should == 'Cases'
    end
  end
  
end