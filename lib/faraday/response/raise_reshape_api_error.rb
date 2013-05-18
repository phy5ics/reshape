require 'faraday'
require 'multi_json'

module Faraday
  class Response::RaiseReshapeError < Response::Middleware
    def on_complete(response)
      case response[:status].to_i
      when 400
        raise Reshape::BadRequest, error_message(response)
      when 401
        raise Reshape::Unauthorized, error_message(response)
      when 403
        raise Reshape::Forbidden, error_message(response)
      when 404
        raise Reshape::NotFound, error_message(response)
      when 406
        raise Reshape::NotAcceptable, error_message(response)
      when 422
        raise Reshape::UnprocessableEntity, error_message(response)
      when 500
        raise Reshape::InternalServerError, error_message(response)
      when 501
        raise Reshape::NotImplemented, error_message(response)
      when 502
        raise Reshape::BadGateway, error_message(response)
      when 503
        raise Reshape::ServiceUnavailable, error_message(response)
      end
    end

    def error_message(response)
      message = if (body = response[:body]) && !body.empty?
        if body.is_a?(String)
          body = MultiJson.load(body, :symbolize_keys => true)
        end
        ": #{body[:error] || body[:message] || ''}"
      else
        ''
      end
      "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{response[:status]}#{message}"
    end
  end
end
