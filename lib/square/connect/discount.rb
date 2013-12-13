module Square
  module Connect
    class Discount
      attr_accessor :name, :applied_money

      def initialize(attributes = {})
        raise
        self.name = attributes[:name]
        self.applied_money = if attributes[:applied_money]
          Money.new attributes[:applied_money]
        end
      end
    end
  end
end