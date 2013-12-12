require 'square/connect/connections'

module Square
  module Connect
    class Merchant < Node
      include Connections::Payments
      include Connections::Refunds
      include Connections::Settlements

      attr_accessor :name, :email, :country_code, :language_code

      def initialize(*args)
        super do |attributes|
          self.name = attributes[:name]
          self.email = attributes[:email]
          self.country_code = attributes[:country_code]
          self.language_code = attributes[:language_code]
        end
      end

      class << self
        def me(access_token)
          new :me, access_token
        end
      end
    end
  end
end