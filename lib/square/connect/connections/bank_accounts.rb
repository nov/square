module Square
  module Connect
    module Connections
      module BankAccounts
        def bank_account(bank_account_id, params = nil)
          access_token_required!
          BankAccount.new(
            bank_account_id,
            merchant_id: identifier,
            access_token: access_token
          ).fetch
        end
      end
    end
  end
end