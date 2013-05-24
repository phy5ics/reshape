require 'multi_json'

module Reshape
  module Request
    def get(path, options={}, raw=false, force_urlencoded=false)
      request(:get, path, options, raw, force_urlencoded)
    end
    
    def post(path, options={}, raw=false, force_urlencoded=false)
      puts 'OPTIONZZZZ: '
      puts options
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
        # request.params = options[:body] if options[:body]
        case method
        when :delete, :get
          request.url(path, options)
        when :patch, :post, :put
          request.path = path
          request.body = options unless options.empty?
        end
      end

      if raw
        response
      else
        response.body
      end
    end

  end
end
