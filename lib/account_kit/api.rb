module AccountKit
  class API
    ME_URL = "https://graph.accountkit.com/#{VERSION}/me".freeze
    GRANT_TYPE = 'authorization_code'.freeze

    attr_accessor :app_id, :app_secret, :version

    def initialize(options = {})
      @app_id = options[:app_id] || ENV['ACCOUNT_KIT_APP_ID']
      @app_secret = options[:app_secret] || ENV['ACCOUNT_KIT_APP_SECRET']
      @version = options[:version] || ENV['ACCOUNT_KIT_VERSION']
    end

    def access_token(code)
      uri = build_uri(code)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = build_request(uri)
      response = http.request(request)
      JSON.parse(response.body)
    end

    private

    def build_request(uri)
      request = Net::HTTP::Get.new(uri.request_uri)
      request.content_type = 'application/json'
      request
    end

    def build_uri(code)
      uri = URI(access_token_url)
      uri.query = URI.encode_www_form(access_token_params(code))
      uri
    end

    def access_token_params(code)
      {
        grant_type: GRANT_TYPE,
        code: code,
        access_token: app_access_token
      }
    end

    def access_token_url
      "https://graph.accountkit.com/#{@version}/access_token"
    end

    def app_access_token
      ['EM', @app_id, @app_secret].join('|')
    end
  end
end
