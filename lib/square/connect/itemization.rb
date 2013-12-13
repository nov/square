module Square
  module Connect
    class Itemization
      attr_accessor :name, :quantity, :item_detail, :notes, :item_variation_name, :total_money, :single_quantity_money, :gross_sales_money, :discount_money, :taxes, :discounts

      def initialize(attributes = {})
        self.name = attributes[:name]
        self.quantity = attributes[:quantity]
        self.item_detail = if attributes[:item_detail].present?
          ItemDetail.new attributes[:item_detail]
        end
        self.notes = attributes[:notes]
        self.item_variation_name = attributes[:item_variation_name]
        [
          :total_money,
          :single_quantity_money,
          :gross_sales_money,
          :discount_money
        ].each do |money_key|
          if attributes[money_key]
            self.send "#{money_key}=", Money.new(attributes[money_key])
          end
        end
        self.taxes = Array(attributes[:taxes]).collect do |tax_attributes|
          Tax.new tax_attributes
        end
        self.discounts = Array(attributes[:discounts]).collect do |discount_attributes|
          Discount.new discount_attributes
        end
      end
    end
  end
end