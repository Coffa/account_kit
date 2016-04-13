module AccountKit
  class API
    ME_URL = "https://graph.accountkit.com/#{VERSION}/me".freeze
    ACCESS_TOKEN_URL = "https://graph.accountkit.com/#{VERSION}/access_token".freeze
    GRANT_TYPE = 'authorization_code'.freeze

    attr_accessor :app_id, :app_secret, :version

    def initialize(options = {})
      @app_id = options[:app_id] || ENV['ACCOUNT_KIT_APP_ID']
      @app_secret = options[:app_secret] || ENV['ACCOUNT_KIT_APP_SECRET']
      @version = options[:version] || ENV['ACCOUNT_KIT_VERSION']
    end
  end
end
