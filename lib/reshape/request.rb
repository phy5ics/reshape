require 'multi_json'
require 'multi_xml'

module Reshape
  module Request
    def get(path, options={}, raw=false, force_urlencoded=false)
      request(:get, path, options, raw, force_urlencoded)
    end

    private

    def request(method, path, options, raw, force_urlencoded)
      response = connection(raw, force_urlencoded).send(method) do |request|
        # puts '>>>>>>>>>>>>>>>>>>'
        path = "#{path}.#{response_format}"
        options.merge!('api-key' => api_key)
        # puts "path: #{path}"
        # puts "options: #{options}"
        request.url(path, options)
      end

      if raw
        response
      else
        if response_format == 'json'
          response.body
        elsif response_format == 'xml'
          response.body.response
        end
      end
    end

  end
end
