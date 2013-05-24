unless ENV['CI']
  require 'simplecov'
  SimpleCov.start do
    add_filter "/spec"
  end
end

require 'reshape'
require 'rspec'
require 'webmock/rspec'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/cassettes'
  c.hook_into :webmock
  c.ignore_localhost = true
  c.allow_http_connections_when_no_cassette = true
end

def a_get(url)
  a_request(:get, shapeways_url(url))
end

def a_post(url)
  a_request(:post, shapeways_url(url))
end

def stub_get(url)
  stub_request(:get, shapeways_url(url))
end

def stub_post(url)
  stub_request(:post, shapeways_url(url))
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end

def shapeways_url(url)
  "http://api.shapeways.com/#{url}/#{@client.api_version}"
end
