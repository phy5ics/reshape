require 'bundler/setup'
require 'sinatra/base'
require 'omniauth-shapeways'
require 'reshape'

# Get these keys from http://developer.shapeways.com
ENV['SHAPEWAYS_CONSUMER_KEY'] = ''
ENV['SHAPEWAYS_CONSUMER_SECRET'] = ''

# To run this example:
# $ bundle install
# $ rackup -p 9293 config.ru &

class App < Sinatra::Base
  get '/' do
    redirect '/auth/shapeways'
  end

  get '/auth/:provider/callback' do
    auth = request.env['omniauth.auth']
    
    client = Reshape::Client.new({
      consumer_token: ENV['SHAPEWAYS_CONSUMER_KEY'], 
      consumer_secret: ENV['SHAPEWAYS_CONSUMER_SECRET'], 
      oauth_token: auth.credentials.token, 
      oauth_secret: auth.credentials.secret
    })
    
    materials = client.materials
    
    erb "<h1>#{params[:provider]}</h1>
         <pre>#{JSON.pretty_generate(auth)}</pre>
         <pre>#{JSON.pretty_generate(materials)}</pre>"
  end

  get '/auth/failure' do
    MultiJson.encode(request.env)
  end
end

use Rack::Session::Cookie

use OmniAuth::Builder do
  provider :shapeways, ENV['SHAPEWAYS_CONSUMER_KEY'], ENV['SHAPEWAYS_CONSUMER_SECRET']
end

run App.new