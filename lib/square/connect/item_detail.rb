module Square
  module Connect
    class ItemDetail
      attr_accessor :category_name, :sku

      def initialize(attributes = {})
        self.category_name = attributes[:category_name]
        self.sku = attributes[:sku]
      end
    end
  end
end