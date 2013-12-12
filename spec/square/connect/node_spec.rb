require 'spec_helper'

describe Square::Connect::Node do
  let(:klass) { Square::Connect::Node }
  let(:identifier) { 'node_id' }
  let(:access_token) { 'access_token' }

  describe '#initialize' do
    subject { klass.new identifier }
    its(:identifier) { should == identifier }
    its(:endpoint) { should == File.join(Square::Connect::ROOT_URL, identifier) }

    context 'when access_token given' do
      subject { klass.new identifier, access_token }

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
    context 'when valid access_token given' do
      let(:instance) { klass.new identifier, access_token }

      it  do
        merchant = mock_request identifier, 'merchant/me', request_header: {'Authorization' => "Bearer #{access_token}"} do
          instance.fetch
        end
        merchant.should be_a klass
      end
    end

    context 'when invalid access_token given' do
      let(:instance) { klass.new identifier, access_token }

      it 'should reaise Square::Connect::Error' do
        expect do
          mock_request identifier, 'error/unauthorized', request_header: {'Authorization' => "Bearer #{access_token}"}, status: [401, 'Unauthorized'] do
            instance.fetch
          end
        end.to raise_error(Square::Connect::Error) { |e|
          e.status.should == 401
          e.type.should == 'service.unauthorized'
          e.message.should == 'Unauthorized'
        }
      end
    end

    context 'otherwise' do
      let(:instance) { klass.new identifier }

      it do
        expect do
          instance.fetch
        end.to raise_error Square::Exception, 'access_token required'
      end
    end
  end

  describe '.me' do

  end
end