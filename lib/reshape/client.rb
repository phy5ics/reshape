require 'reshape/configuration'
require 'reshape/connection'
require 'reshape/request'
require 'reshape/error'
require 'reshape/client/orders'
require 'reshape/client/materials'
require 'reshape/client/models'
require 'reshape/client/printers'
require 'reshape/client/price'

module Reshape
  class Client
    attr_accessor(*Configuration::VALID_OPTIONS_KEYS)

    def initialize(options={})
      options = Reshape.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end
    
    include Reshape::Configuration
    include Reshape::Connection
    include Reshape::Request
    include Reshape::Client::Orders
    include Reshape::Client::Materials
    include Reshape::Client::Models
    include Reshape::Client::Printers
    include Reshape::Client::Price
    
  end
end