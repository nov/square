module Square
  module Connect
    module Connections
      module Payments
        def payments
          access_token_required!
          payments = handle_response do
            access_token.get endpoint_for(identifier, :payments)
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