require 'multi_json'

module Reshape
  module Request
    def get(path, options={}, raw=false, force_urlencoded=false)
      request(:get, path, options, raw, force_urlencoded)
    end
    
    def post(path, options={}, raw=false, force_urlencoded=false)
      request(:post, path, options, raw, force_urlencoded)
    end

    def put(path, options={}, raw=false, force_urlencoded=false)
      request(:put, path, options, raw, force_urlencoded)
    end

    def delete(path, options={}, raw=false, force_urlencoded=false)
      request(:delete, path, options, raw, force_urlencoded)
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
        response.body
      end
    end

  end
end
