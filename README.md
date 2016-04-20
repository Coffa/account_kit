[![Code Climate](https://codeclimate.com/github/Coffa/account_kit/badges/gpa.svg)](https://codeclimate.com/github/Coffa/account_kit)

# AccountKit
A light-weight Ruby API client for [Facebook Account Kit](https://developers.facebook.com/docs/accountkit) with no dependency.
A video demo of the Account Kit can be found [here](https://www.facebook.com/FacebookforDevelopers/videos/10153620979588553/).
You can find a demo app [here](https://github.com/vnnoder/account_kit_demo)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'account_kit'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install account_kit

## Usage

### Configuration

To work with Account Kit API, you need to provide Facebook App ID, Account Kit App Secret. If you don't specify an api version, the gem will call v1.0. You can also specify which version you want to use:

```
AccountKit.configure do |config|
  config.app_id      = '1234566789'
  config.app_secret  = 'abcdefghijklm'
  config.api_version = 'v1.0'
end
```

AccountKit support App Secret Proof, if you turn on "Require App Secret", add the following config:

```
config.require_app_secret = true
```

### API

If you turn off Enable Client Access Token Flow and use [Authorization Code Flow](https://developers.facebook.com/docs/accountkit/accesstokens), you need to provide the authorization code after user authenticate with Account Kit in order to get an access token:

```
response     = JSON.parse(AccountKit.access_token(authorization_code).body)
access_token = response['access_token']
```
If you turn on Enable Client Access Token Flow, you should already have an access token after user authenticate. To get account information, use the access token to get user's email or phone number:

```
response     = JSON.parse(AccountKit.me(access_token).body)
email        = response[:email][:address]
phone_number = response[:phone][:number]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Coffa/account_kit. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

