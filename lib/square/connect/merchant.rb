require 'square/connect/connections'

module Square
  module Connect
    class Merchant
      include Connections::Payments
      include Connections::Refunds
      include Connections::Settlements
      include Connections::BankAccounts
    end
  end
end