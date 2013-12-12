module Square
  module Connect
    class BankAccount < Node
      attr_accessor :merchant, :bank_name, :name, :type, :routing_number, :account_number_suffix, :currency_code

      def initialize(*args)
        super do |attributes|
          self.merchant = if attributes[:merchant_id]
            Merchant.new attributes[:merchant_id]
          else
            Merchant.new :me
          end
          self.bank_name = attributes[:bank_name]
          self.name = attributes[:name]
          self.type = attributes[:type]
          self.routing_number = attributes[:routing_number]
          self.account_number_suffix = attributes[:account_number_suffix]
          self.currency_code = attributes[:currency_code]
        end
      end
    end
  end
end