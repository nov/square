require 'spec_helper'

describe Square::Connect::Merchant do
  let(:klass) { Square::Connect::Merchant }
  let(:identifier) { 'merchant_id' }
  let(:name) { 'Nov Matake' }
  let(:email) { 'nov@matake.jp' }
  let(:country_code) { 'JP' }
  let(:language_code) { 'ja-JP' }
  let(:access_token) { 'access_token' }

  describe '#initialize' do
    subject { klass.new attributes }
    let(:attributes) do
      {
        identifier: identifier,
        email: email,
        name: name,
        country_code: country_code,
        language_code: language_code
      }
    end
    its(:identifier) { should == identifier }
    its(:name) { should == name }
    its(:email) { should == email }
    its(:country_code) { should == country_code }
    its(:language_code) { should == language_code }
    its(:endpoint) { should == File.join(Square::Connect::ROOT_URL, identifier) }

    context 'when access_token given' do
      subject { klass.new attributes.merge(access_token: access_token) }

      context 'as String' do
        let(:access_token) { 'access_token' }
        its(:access_token) { should be_a Square::OAuth2::AccessToken }
      end

      context 'as Square::OAuth2::AccessToken' do
        let(:access_token) { Square::OAuth2::AccessToken.new 'access_token' }
        its(:access_token) { should be_a Square::OAuth2::AccessToken }
      end
    end
  end

  describe '#fetch' do
    it do
      merchant = mock_request identifier, 'merchant/me' do
        instance = klass.new identifier, access_token
        instance.fetch
      end
      merchant.should be_a klass
    end
  end

  describe '.me' do
    subject { klass.me access_token }
    its(:identifier) { should == :me }
    its(:access_token) { should be_a Square::OAuth2::AccessToken }
  end
end