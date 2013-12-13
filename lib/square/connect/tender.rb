module Square
  module Connect
    class Tender
      attr_accessor :type, :name, :card_brand, :pan_suffix, :entry_method, :payment_note, :total_money, :tendered_money, :change_back_money

      def initialize(attributes = {})
        self.type = attributes[:type]
        self.name = attributes[:name]
        self.card_brand = attributes[:card_brand]
        self.pan_suffix = attributes[:pan_suffix]
        self.entry_method = attributes[:entry_method]
        self.payment_note = attributes[:payment_note]
        [
          :total_money,
          :tendered_money,
          :change_back_money
        ].each do |money_attr|
          if attributes[money_attr]
            self.send "#{money_attr}=", Money.new(attributes[money_attr])
          end
        end
      end
    end
  end
end