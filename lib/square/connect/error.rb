module Square
  module Connect
    class Error < StandardError
      attr_accessor :status, :type

      def initialize(status, error)
        self.status = status
        self.type = error[:type]
        super error[:message]
      end
    end
  end
end