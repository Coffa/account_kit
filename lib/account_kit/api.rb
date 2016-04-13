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
      uri = build_access_token_uri(code)
      send_payload(uri)
    end

    def me(access_token)
      uri = build_me_uri(access_token)
      send_payload(uri)
    end

    private

    def send_payload(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(uri.request_uri)
      request.content_type = 'application/json'

      response = http.request(request)
      JSON.parse(response.body)
    end

    def build_access_token_uri(code)
      uri = URI(access_token_url)
      uri.query = URI.encode_www_form(access_token_params(code))
      uri
    end

    def build_me_uri(access_token)
      uri = URI(me_url)
      uri.query = URI.encode_www_form(access_token: access_token)
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

    def me_url
      "https://graph.accountkit.com/#{@version}/me"
    end

    def app_access_token
      ['EM', @app_id, @app_secret].join('|')
    end
  end
end
