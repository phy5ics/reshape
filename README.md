# Reshape: An API Wrapper for Shapeways

This gem is an API wrapper for the [Shapeways API](http://developer.shapeways.com/)

It supports the Shapeways API which uses OAuth 1.0a.

## Usage

This gem does not contain any methods for authentication. Everyone tends to use something a little bit different, so the goal was to abstract out the OAuth authentication and allow you to bring your own, if you desire. You only need to supply the tokens. However, I also created an OmniAuth strategy to support the Shapeways API. So, if you're already using OmniAuth in your project, you can easily add the strategy with my omniauth-shapewats gem according to the instructions found here: [Shapeways OmniAuth Strategy](/phy5ics/omniauth-shapeways)

Add the gem to your `Gemfile`:

```ruby
gem 'reshape'
```

Then instantiate the client using the oAuth tokens (this example implies using Foreman and an .env file that contain these values):

```ruby
Reshape::Client.new({
  consumer_token: ENV['SHAPEWAYS_CONSUMER_TOKEN'], 
  consumer_secret: ENV['SHAPEWAYS_CONSUMER_SECRET'], 
  oauth_token: ENV['SHAPEWAYS_OAUTH_TOKEN'], 
  oauth_secret: ENV['SHAPEWAYS_OAUTH_SECRET']
})
```

The consumer_token and consumer_secret are supplied by Shapeways once you create a developer account and an app. Additional information can be found on the [Shapeways Developer Site](http://developer.shapeways.com/).

The oauth_token and oauth_secret are the access tokens that are received from the OAuth transaction. In this Sinatra method that uses the OmniAuth callback method, you can see how to parse the access tokens out of the response and use it to instantiate the Reshape client along with your pre-defined consumer tokens:

```ruby
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
```

```
gem 'oauth2'
```

```ruby
key = ENV['SHAPEWAYS_CONSUMER_KEY']
secret = ENV['SHAPEWAYS_CONSUMER_SECRET']
auth_client = OAuth2::Client.new(key, secret, site: "https://api.shapeways.com", token_url: '/oauth2/token')
access = auth_client.client_credentials.get_token

token = access.token

client = Reshape::Client.new({
  consumer_token: ENV['SHAPEWAYS_CONSUMER_KEY'],
  consumer_secret: ENV['SHAPEWAYS_CONSUMER_SECRET'],
  oauth_token: token,
  oauth_secret: nil
})

materials = client.materials
```

Check the examples directory for a full example using Sinatra.

## Tests

Note that rspec is using vcr for fixtures. If you delete files from spec/fixtures/cassettes, the tests will fail. They use dummy tokens, and will attempt to communicate with the live API with missing OAuth parameters. In order to test against the live API and generate your own cassettes, create a .env file with the following parameters:

```ruby
	SHAPEWAYS_CONSUMER_TOKEN='your consumer token from Shapeways'
	SHAPEWAYS_CONSUMER_SECRET='your consumer secret from Shapeways'
	SHAPEWAYS_OAUTH_TOKEN='OAuth token that are returned from a successful authentication'
	SHAPEWAYS_OAUTH_SECRET='OAuth secret that are returned from a successful authentication'
```

From there, you can run _foreman run bundle exec rake_ to regenerate the cassettes using live data in conjunction with your credentials. Just a word of warning: don't commit those cassettes to a public repo, as they will contain valid tokens that could potentially be used to hijack a live application that uses those credentials.

## Todo

Add rspec tests for adding models and photos.


## <a name="build"></a>Build Status
[![Build Status](https://secure.travis-ci.org/phy5ics/reshape.png?branch=master)][travis]

[travis]: http://travis-ci.org/phy5ics/omniauth-shapeways

## <a name="dependencies"></a>Dependency Status
[![Dependency Status](https://gemnasium.com/phy5ics/reshape.png?travis)][gemnasium]

[gemnasium]: https://gemnasium.com/phy5ics/reshape

## Contributing

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2013 John Barton. See [LICENSE](https://github.com/phy5ics/reshape/blob/master/LICENSE.txt) for details.
