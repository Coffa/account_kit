require 'spec_helper'
require 'account_kit/api'

describe AccountKit::API do
  let(:app_id) { '123456789' }
  let(:app_secret) { 'abcdef' }
  let(:api_version) { 'v1.0' }
  describe 'initialize' do
    it 'accepts app_id' do
      api = AccountKit::API.new(app_id: app_id)
      expect(api.app_id).to eq(app_id)
    end

    it 'accepts app_secret' do
      api = AccountKit::API.new(app_secret: app_secret)
      expect(api.app_secret).to eq(app_secret)
    end

    it 'accepts api_version' do
      api = AccountKit::API.new(api_version: api_version)
      expect(api.api_version).to eq(api_version)
    end
  end

  describe 'access_token' do
    let(:code) { 'test code'}

    it 'does something' do
      api = AccountKit::API.new(app_id: app_id, app_secret: app_secret)
      response = api.access_token(code)
      pp response
    end

    it 'does something' do
      api = AccountKit::API.new(app_id: app_id, app_secret: app_secret)
      response = api.me('test access_token')
      pp response
    end
  end

  describe 'class_methods' do
    let(:code) { 'test code'}

    before do
      AccountKit::API.app_id = app_id
      AccountKit::API.app_secret = app_secret
      AccountKit::API.api_version = api_version
    end

    it 'calls instantce method' do
      response = AccountKit::API.access_token(code)
      pp response
    end
  end
end
