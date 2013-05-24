require 'spec_helper'

describe Reshape::Client::Materials do
  let(:client) do
    shapeways_client
  end
  
  after(:each) do
    shapeways_client.reset
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