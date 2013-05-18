# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Faraday::Response do
  before do
    @client = Reshape::Client.new(api_key: 'foo')
  end

  {
    400 => Reshape::BadRequest,
    401 => Reshape::Unauthorized,
    403 => Reshape::Forbidden,
    404 => Reshape::NotFound,
    406 => Reshape::NotAcceptable,
    422 => Reshape::UnprocessableEntity,
    500 => Reshape::InternalServerError,
    501 => Reshape::NotImplemented,
    502 => Reshape::BadGateway,
    503 => Reshape::ServiceUnavailable,
  }.each do |status, exception|
    context "when HTTP status is #{status}" do

      before do
        stub_get('talks.json?api-key=foo').to_return(:status => status)
      end

      it "should raise #{exception.name} error" do
        lambda do
          @client.talks
        end.should raise_error(exception)
      end
    end
  end
end