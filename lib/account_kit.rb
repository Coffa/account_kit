require 'net/http'
require 'json'
require 'openssl'

require 'account_kit/version'
require 'account_kit/base'
require 'account_kit/config'

class AccountKit
  def self.configure
    yield Config
  end
end
