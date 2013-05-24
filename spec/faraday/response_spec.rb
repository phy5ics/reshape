# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Faraday::Response do
  before do
    @client = Reshape::Client.new({
      consumer_token: ENV['SHAPEWAYS_CONSUMER_TOKEN'], 
      consumer_secret: ENV['SHAPEWAYS_CONSUMER_SECRET'], 
      oauth_token: ENV['SHAPEWAYS_OAUTH_TOKEN'], 
      oauth_secret: ENV['SHAPEWAYS_OAUTH_SECRET'], 
      proxy: 'http://localhost:8888'
    })
  end

  {
    400 => Reshape::BadRequest,
    401 => Reshape::Unauthorized,
    403 => Reshape::Forbidden,
    404 => Reshape::NotFound,
    406 => Reshape::NotAcceptable,
    422 => Reshape::UnprocessableEntity,
    500 => Reshape::InternalServerError,
    # 501 => Reshape::NotImplemented,
    502 => Reshape::BadGateway,
    503 => Reshape::ServiceUnavailable,
  }.each do |status, exception|
    context "when HTTP status is #{status}" do

      before do
        stub_get('orders/cart').to_return(:status => status)
      end

      it "should raise #{exception.name} error" do
        lambda do
          @client.list_cart
        end.should raise_error(exception)
      end
    end
  end
end