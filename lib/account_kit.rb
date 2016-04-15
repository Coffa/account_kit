require 'net/http'
require 'json'

require 'account_kit/version'
require 'account_kit/api'
require 'account_kit/config'

module AccountKit
  extend self

  def configure
    yield Config
  end

  def access_token(code)
    API.access_token(code)
  end

  def me(access_token)
    API.me(access_token)
  end
end
