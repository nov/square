require 'spec_helper'

describe Square::Connect::Payment do
  let(:klass) { Square::Connect::Payment }
  let(:identifier) { 'payment_id' }
  let(:merchant_id) { 'merchant_id' }
  let(:creator_id) { 'creator_id' }
  let(:access_token) { 'access_token' }

  describe '#initialize' do
    describe 'merchant' do
      context 'when merchant_id given' do
        subject { klass.new identifier, merchant_id: merchant_id }
        its(:merchant) { should be_a Square::Connect::Merchant }
        its(:endpoint) { should == File.join(Square::Connect::ROOT_URL, "#{merchant_id}/payments/#{identifier}") }
      end

      context 'otherwise' do
        subject { klass.new identifier }
        its(:merchant) { should be_a Square::Connect::Merchant }
        its(:endpoint) { should == File.join(Square::Connect::ROOT_URL, "me/payments/#{identifier}") }
      end
    end

    describe 'creator' do
      context 'when creator_id given' do
        subject { klass.new identifier, creator_id: creator_id }
        its(:creator) { should be_a Square::Connect::Merchant }
      end

      context 'otherwise' do
        subject { klass.new identifier }
        its(:creator) { should be_nil }
      end
    end
  end

  describe '#fetch' do
    let(:instance) { klass.new identifier, access_token }
    it do
      fetched = mock_request instance.endpoint, 'payments/single' do
        instance.fetch
      end
      fetched.should be_a klass
    end
  end
end