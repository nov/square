require 'spec_helper'

describe Square::Connect::BankAccount do
  let(:klass) { Square::Connect::BankAccount }
  let(:identifier) { 'bank_account_id' }
  let(:merchant_id) { 'merchant_id' }
  let(:access_token) { 'access_token' }

  describe '#initialize' do
    context 'when merchant_id given' do
      subject { klass.new identifier, merchant_id: merchant_id }
      its(:endpoint) { should == File.join(Square::Connect::ROOT_URL, "#{merchant_id}/bank_accounts/#{identifier}") }
    end

    context 'otherwise' do
      subject { klass.new identifier }
      its(:endpoint) { should == File.join(Square::Connect::ROOT_URL, "me/bank_accounts/#{identifier}") }
    end
  end

  describe '#fetch' do
    let(:instance) { klass.new identifier, access_token }

    it do
      settlement = mock_request "me/bank_accounts/#{identifier}", 'bank_account/mine' do
        instance.fetch
      end
      settlement.should be_a klass
    end
  end
end