require 'spec_helper'

describe Square::OAuth2::Client do
  let(:client_id) { 'client_id' }
  let(:client_secret) { 'client_secret' }
  let(:klass) { Square::OAuth2::Client }

  describe '#initialize' do
    subject { klass.new client_id }

    it { should be_a Rack::OAuth2::Client }

    describe 'identifeir' do
      context 'when missing' do
        it do
          expect do
            klass.new
          end.to raise_error AttrRequired::AttrMissing
        end
      end

      context 'when given' do
        context 'as the first arg' do
          subject { klass.new client_id }
          its(:identifier) { should == client_id }
        end

        context 'as Hash' do
          subject { klass.new identifier: client_id }
          its(:identifier) { should == client_id }
        end
      end
    end

    describe 'secret' do
      context 'when missing' do
        subject { klass.new client_id }
        its(:secret) { should be_nil }
      end

      context 'when given' do
        context 'as the second arg' do
          subject { klass.new client_id, client_secret }
          its(:secret) { should == client_secret }
        end

        context 'as Hash' do
          subject { klass.new identifier: client_id, secret: client_secret }
          its(:secret) { should == client_secret }
        end
      end
    end

    describe 'other attributes' do
      its(:host) { should == 'squareup.com' }
      its(:authorization_uri) { should == "https://squareup.com/oauth2/authorize?client_id=#{client_id}&response_type=code" }
    end
  end

  describe 'access_token!' do
    let(:authorization_code) { 'authorization_code' }
    let(:redirect_uri) { 'https://client.example.com/callback' }
    let(:token_uri) { File.join(Square::OAuth2::ROOT_URL, 'oauth2/token') }

    it "should access to '#{Square::OAuth2::ROOT_URL}' with client_auth_method as body" do
      mock_request token_uri, 'token', method: :post, params: {
        grant_type: 'authorization_code',
        client_id: client_id,
        code: authorization_code,
        redirect_uri: redirect_uri
      } do
        client = klass.new client_id, redirect_uri: redirect_uri
        client.authorization_code = authorization_code
        client.access_token!
      end
    end

    context 'when invalid grant' do
      it do
        expect do
          mock_request token_uri, 'invalid_grant', method: :post, status: [400, 'Bad Request'] do
            client = klass.new client_id, redirect_uri: redirect_uri
            client.authorization_code = authorization_code
            client.access_token!
          end
        end.to raise_error Rack::OAuth2::Client::Error
      end
    end
  end
end