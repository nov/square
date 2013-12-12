module Square
  module Connect
    class Money
      attr_accessor :amount, :currency_code

      def initialize(attributes = {})
        self.amount = attributes[:amount]
        self.currency_code = attributes[:currency_code]
      end
    end
  end
end