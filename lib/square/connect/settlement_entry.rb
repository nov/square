module Square
  module Connect
    class SettlementEntry
      attr_accessor :type, :payment, :amount_money, :fee_money

      def initialize(attributes = {})
        self.type = attributes[:type]
        self.payment = if attributes[:payment_id]
          Payment.new attributes[:payment_id]
        end
        [
          :amount_money,
          :fee_money
        ].each do |money_key|
          if attributes[money_key].present?
            self.send "#{money_key}=", Money.new(attributes[money_key])
          end
        end
      end
    end
  end
end