require 'spec_helper'

describe Square::Connect::Connections::Settlements do
  let(:access_token) { 'access_token' }
  let(:me) { Square::Connect::Merchant.me access_token }

  describe '#payments' do
    it 'should return an array of Square::Connect::Settlement' do
      settlements = mock_request 'me/settlements', 'settlements/list' do
        me.settlements
      end
      settlements.should be_a Array
      settlements.should_not be_blank
      settlements.each do |settlement|
        settlement.should be_a Square::Connect::Settlement
      end
    end
  end
end