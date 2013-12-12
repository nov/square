module Square
  module Connect
    class Device
      attr_accessor :identifier, :name

      def initialize(attributes = {})
        self.identifier = attributes[:id]
        self.name = attributes[:name]
      end
    end
  end
end