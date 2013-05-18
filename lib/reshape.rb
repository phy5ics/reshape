require 'reshape/version'
require 'reshape/configuration'
require 'reshape/client'
require 'reshape/error'

module Reshape
  extend Configuration
  class << self
    # Alias for Reshape::Client.new
    #
    # @return [Reshape::Client]
    def new(options={})
      Reshape::Client.new(options)
    end

    def respond_to?(method, include_private=false)
      new.respond_to?(method, include_private) || super(method, include_private)
    end
  end
end
