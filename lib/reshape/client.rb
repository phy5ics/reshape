require 'reshape/connection'
require 'reshape/request'
require 'reshape/error'

module Reshape
  class Client
    attr_accessor(*Configuration::VALID_OPTIONS_KEYS)

    def initialize(options={})
      options = Reshape.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end
    
    include Reshape::Connection
    include Reshape::Request
    
  end
end