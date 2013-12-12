module Square
  module Connect
    class BankAccount < Node
      attr_accessor :merchant, :bank_name, :name, :type, :routing_number, :account_number_suffix, :currency_code

      def initialize(*args)
        super do |attributes|
          self.merchant = if attributes[:merchant_id]
            Merchant.new attributes[:merchant_id], access_token
          else
            Merchant.me access_token
          end
          self.bank_name = attributes[:bank_name]
          self.name = attributes[:name]
          self.type = attributes[:type]
          self.routing_number = attributes[:routing_number]
          self.account_number_suffix = attributes[:account_number_suffix]
          self.currency_code = attributes[:currency_code]
          self.endpoint = endpoint_for merchant.identifier, :bank_accounts, identifier
        end
      end
    end
  end
end