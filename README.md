# Leisureking


This gem works as a simple Ruby wrapper for the Leisureking API. The Leisureking API has a very straight forward REST API. 

All this gem does, is make it a little bit simpler to use the API:
- You can set your credentials via Rails config
- Authrization keys are renewed/requested automatically
- You can make REST requests right away, without having to worry about authentication


Original documentation is here: https://survey.leisureking.eu/v1l/docs/authentication

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'leisureking'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install leisureking

## Configuration

First, obtain an API key and shared secret from LeisureKing. Set it up like this:
```ruby
LeisureKing::Config.api_key      = "MY-API-KEY"
LeisureKing::Config.api_secret   = "MY-API-SHARED-SECRET"
```

To use this gem in a Rails project:
```ruby
# config/development.rb
config.leisure_king.api_key     = "MY-API-KEY"
config.leisure_king.api_secret  = "MY-API-SECRET"

```

## Usage

All there is left is to use the API according to the documentation:

```ruby
LeisureKing::API.send_request("assortiment/getassortimentdatabyassortimentid", {id_assortiment: 5625})
# => Returns Hash from JSON response
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/henkm/leisureking.

## License

The gem is made with ❤️ by the smart people from Eskes Media. This gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
