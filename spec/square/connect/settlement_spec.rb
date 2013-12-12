require 'spec_helper'

describe Square::Connect::Settlement do
  let(:klass) { Square::Connect::Settlement }
  let(:identifier) { 'settlement_id' }
  let(:merchant_id) { 'merchant_id' }
  let(:access_token) { 'access_token' }

  describe '#initialize' do
    context 'when merchant_id given' do
      subject { klass.new identifier, access_token, merchant_id: merchant_id }
      its(:endpoint) { should == File.join(Square::Connect::ROOT_URL, "#{merchant_id}/settlements/#{identifier}") }
    end

    context 'otherwise' do
      subject { klass.new identifier, access_token }
      its(:endpoint) { should == File.join(Square::Connect::ROOT_URL, "me/settlements/#{identifier}") }
    end
  end

  describe '#fetch' do
    let(:instance) { klass.new identifier, access_token }

    it do
      settlement = mock_request "me/settlements/#{identifier}", 'settlements/single' do
        instance.fetch
      end
      settlement.should be_a klass
    end
  end
end