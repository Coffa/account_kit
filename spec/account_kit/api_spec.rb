require 'spec_helper'
require 'account_kit/api'

describe AccountKit::API do
  describe 'initialize' do
    let(:app_id) { '123456789' }
    let(:app_secret) { 'abcdef' }
    let(:app_version) { 'v0.3' }

    it 'accepts app_id' do
      api = AccountKit::API.new(app_id: app_id)
      expect(api.app_id).to eq(app_id)
    end

    it 'accepts app_secret' do
      api = AccountKit::API.new(app_secret: app_secret)
      expect(api.app_secret).to eq(app_secret)
    end

    it 'accepts app_version' do
      api = AccountKit::API.new(app_id: app_id)
      expect(api.app_id).to eq(app_id)
    end
  end
end