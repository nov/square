require 'spec_helper'

describe Square::OAuth2::AccessToken do
  let(:klass) { Square::OAuth2::AccessToken }

  describe '#initialize' do
    let(:access_token) { 'access_token' }

    describe 'access_token' do
      context 'when missing' do
        it do
          expect do
            klass.new
          end.to raise_error AttrRequired::AttrMissing
        end
      end

      context 'when given' do
        context 'as the first arg' do
          subject { klass.new access_token }
          its(:access_token) { should == access_token }
        end

        context 'as Hash' do
          subject { klass.new access_token: access_token }
          its(:access_token) { should == access_token }
        end
      end
    end
  end
end