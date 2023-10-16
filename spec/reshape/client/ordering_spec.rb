require 'spec_helper'

# describe Reshape::Client::Orders do
describe Reshape::Client::Orders, feature: true, js: true, vcr: {record: :new_episodes} do

  let(:client) do
    shapeways_oauth_client
  end

  after(:each) do
    shapeways_oauth_client.reset
  end

  it "should get all orders" do
    VCR.use_cassette('all_orders_ordering') do
      response = client.orders()
      response.should be_an_instance_of(Hashie::Mash)
      response.result.should == 'success'
      response.ordersStatus.size.should be 1
    end
  end

  it "should get one order" do
    VCR.use_cassette('one_order_ordering') do
      response = client.order(4654952)
      response.should be_an_instance_of(Hashie::Mash)
      response.result.should == 'success'
    end
  end

  it "should make a test order" do
    VCR.use_cassette('make_test_order_ordering') do
      model_id = '12982554'

      order_details = {
        testMode: 1,
        # order deatils
        firstName: 'Alex',
        lastName: 'Hey',
        country: 'US',
        state: 'CA',
        city: 'San Francisco',
        address1: '1250 Market st',
        address2: '#A',
        address3: 'Rafe Records',
        zipCode: '94110',
        phoneNumber: '123456789',
        items: [
          {
            modelId:model_id,
            materialId: "110", #14k Gold Plated Brass
            quantity:1,
          }
        ],
        #incentives: "HOLIDAYS"
        paymentMethod: "credit_card",
        shippingOption: "Cheapest",
        manufacturingSpeed: "Economy",
      }

      response = client.add_order(order_details)
      #response.should be_an_instance_of(Hashie::Mash)
      response.should == false
    end
  end

end
