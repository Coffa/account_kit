module AccountKit
  module Config
    extend self

    attr_accessor :app_id
    attr_accessor :app_secret
    attr_accessor :api_version
    attr_accessor :require_app_secret
  end
end
