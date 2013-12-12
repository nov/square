module Square
  module Connect
    module Connections
      module Payments
        def payments(params = nil)
          access_token_required!
          payments = handle_response do
            access_token.get endpoint_for(identifier, :payments), params
          end
          payments.collect do |payment|
            Payment.new payment.merge(
              access_token: access_token
            )
          end
        end
      end
    end
  end
end