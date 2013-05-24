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
		consumer_token: ENV['SHAPEWAYS_CONSUMER_TOKEN'], 
		consumer_secret: ENV['SHAPEWAYS_CONSUMER_SECRET'], 
		oauth_token: auth.credentials.token, 
		oauth_secret: auth.credentials.secret
	})  

	erb "<pre>#{JSON.pretty_generate(client.materials)}</pre>"

end
```

Check the examples directory for a full example using Sinatra.

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