require 'spec_helper'

describe Reshape::Client::Models do
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

  it "should list models in json" do
    VCR.use_cassette('models') do
      response = client.models
      response.should be_an_instance_of(Hashie::Mash)
      response.result.should == 'success'
    end
  end 
  
  it "should return model details in json" do
    VCR.use_cassette('model') do
      response = client.model(1114694)
      response.should be_an_instance_of(Hashie::Mash)
      response.result.should == 'success'
      response.modelId.should == '1114694'
    end
  end
  
  it "should add a new model" do
    pending 'Need to add STL file to fixtures'
  end
  
  it "should delete the model details in json" do
    pending 'Need to record deletion of a specific model id'
  end
  
  it "should return info about a specific model in json" do
    VCR.use_cassette('model_info') do
      response = client.model_info(1114694)
      response.should be_an_instance_of(Hashie::Mash)
      response.result.should == 'success'
      response.modelId.should == '1114694'
    end
  end
  
  it "should update model info" do
    VCR.use_cassette('update_model_info') do
      response = client.update_model_info(1114694, {description: 'USB thingy'})
      response.should be_an_instance_of(Hashie::Mash)
      response.result.should == 'success'
      response.description.should == 'USB thingy'
    end
  end
  
  it "should add a file to the model" do
    pending 'Need to add STL file to fixtures'
  end
  
  it "should return a model file by a specific version number" do
    VCR.use_cassette('model_file_by_version') do
      response = client.model_file_by_version(1114694, '1')
      response.should be_an_instance_of(Hashie::Mash)
      response.result.should == 'success'
      response.modelVersion.should == '1'
    end
  end
  
  it "should add a photo to the model" do
    pending "Need to add JPG file to fixutres"
  end
  
  
end