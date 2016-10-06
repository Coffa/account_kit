class AccountKit
  module Config
    extend self

    attr_accessor :app_id
    attr_accessor :app_secret
    attr_accessor :api_version
    attr_accessor :require_app_secret

    def api_version
      @api_version || DEFAULT_API_VERSION
    end
  end
end
