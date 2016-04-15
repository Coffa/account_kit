require 'spec_helper'

describe AccountKit do
  let(:app_id) { '123456789' }
  let(:app_secret) { 'abcdef' }
  let(:api_version) { 'v1.0' }

  describe 'access_token' do
    let(:code) { 'test code'}

    before do
      AccountKit.configure do |config|
        config.app_id = app_id
        config.app_secret = app_secret
        config.api_version = api_version
      end
    end

    it 'does something' do
      response = AccountKit.access_token(code)
      pp response
    end

    it 'does something' do
      response = AccountKit.me('test access_token')
      pp response
    end
  end
end
