class AccountKit

  GRANT_TYPE = 'authorization_code'.freeze
  DEFAULT_VERSION = 'v1.0'

  class << self
    # Support older versions
    def method_missing(name, *args, &block)
      new.send(name, *args, &block)
    end
  end

  def initialize(options = {})
    @app_id = options.fetch(:app_id, Config.app_id)
    @app_secret = options.fetch(:app_secret, Config.app_secret)
    @api_version = options.fetch(:api_version, Config.api_version || DEFAULT_VERSION)
    @require_app_secret = options.fetch(:require_app_secret, Config.require_app_secret)
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
    uri.query = URI.encode_www_form(me_params(access_token))
    uri
  end

  def me_params(access_token)
    params = { access_token: access_token }
    params[:appsecret_proof] = appsecret_proof(access_token) if @require_app_secret
    params
  end

  def appsecret_proof(access_token)
    sha256 = OpenSSL::Digest::SHA256.new
    OpenSSL::HMAC.hexdigest(sha256, @app_secret, access_token)
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
