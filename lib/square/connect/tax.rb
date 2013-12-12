module Square
  module Connect
    class Tax
      attr_accessor :name, :applied_money, :rate, :inclusion_type

      def initialize(attributes = {})
        self.name = attributes[:name]
        self.applied_money = if attributes[:applied_money].present?
          Money.new attributes[:applied_money]
        end
        self.rate = attributes[:rate]
        self.inclusion_type = attributes[:inclusion_type]
      end
    end
  end
end