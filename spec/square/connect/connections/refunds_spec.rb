require 'spec_helper'

describe Square::Connect::Connections::Refunds do
  let(:access_token) { 'access_token' }
  let(:me) { Square::Connect::Merchant.me access_token }

  describe '#payments' do
    it 'should return an array of Square::Connect::Refund' do
      refunds = mock_request 'me/refunds', 'refunds/list' do
        me.refunds
      end
      refunds.should be_a Array
      refunds.should_not be_blank
      refunds.each do |refund|
        refund.should be_a Square::Connect::Refund
      end
    end
  end
end