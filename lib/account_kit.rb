require 'net/http'
require 'json'
require 'openssl'

require 'account_kit/version'
require 'account_kit/base'
require 'account_kit/config'

module AccountKit
  extend self

  def configure
    yield Config
  end
end
