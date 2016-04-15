module AccountKit
  class API
    GRANT_TYPE = 'authorization_code'.freeze
    DEFAULT_VERSION = 'v1.0'

    attr_accessor :app_id, :app_secret, :api_version

    class << self
      attr_accessor :app_id, :app_secret, :api_version

      def method_missing(method, *args)
        instance.send(method, *args)
      end

      private

      def instance
        @instance ||= new
      end
    end

    def initialize(options = {})
      @app_id = options[:app_id] || self.app_id || ENV['ACCOUNT_KIT_APP_ID']
      @app_secret = options[:app_secret] || self.app_secret || ENV['ACCOUNT_KIT_APP_SECRET']
      @api_version = options[:api_version] || self.api_version || ENV['ACCOUNT_KIT_API_VERSION'] || DEFAULT_VERSION
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

      http.request(request)
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
      "https://graph.accountkit.com/#{@api_version}/access_token"
    end

    def me_url
      "https://graph.accountkit.com/#{@api_version}/me"
    end

    def app_access_token
      ['AA', @app_id, @app_secret].join('|')
    end
  end
end
