require 'spec_helper'

describe Square::Connect::Connections::Payments do
  let(:access_token) { 'access_token' }
  let(:me) { Square::Connect::Merchant.me access_token }

  describe '#payments' do
    it 'should return an array of Square::Connect::Payment' do
      payments = mock_request 'me/payments', 'payments/list' do
        me.payments
      end
      payments.should be_a Array
      payments.should_not be_blank
      payments.each do |payment|
        payment.should be_a Square::Connect::Payment
      end
    end
  end
end