require 'spec_helper'

describe Reshape::Client::Printers do
  let(:client) do
    shapeways_client
  end
  
  after(:each) do
    shapeways_client.reset
  end

  it "should list printers in json" do
    VCR.use_cassette('printers') do
      response = client.printers
      response.should be_an_instance_of(Hashie::Mash)
      response.result.should == 'success'
      response.printers.should be_a_kind_of(Array)
    end
  end 
  
  it "should return specific printer info in json" do
    VCR.use_cassette('printer') do
      response = client.printer(8)
      response.should be_an_instance_of(Hashie::Mash)
      response.result.should == 'success'
      response.title.should == 'SLS Color Printer'
    end
  end
  
end