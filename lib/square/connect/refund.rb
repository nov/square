module Square
  module Connect
    class Refund
      attr_accessor :identifier, :type, :reason, :refunded_money, :created_at, :processed_at, :payment

      def initialize(attributes = {})
        self.identifier = attributes[:id]
        self.type = attributes[:type]
        self.reason = attributes[:reason]
        self.refunded_money = if attributes[:refunded_money].present?
          Money.new attributes[:refunded_money]
        end
        [
          :created_at,
          :processed_at
        ].each do |time_key|
          if attributes[time_key]
            self.send "#{time_key}=", Time.parse(attributes[time_key])
          end
        end
        self.payment = if attributes[:payment_id]
          Payment.new attributes[:payment_id]
        end
      end
    end
  end
end
