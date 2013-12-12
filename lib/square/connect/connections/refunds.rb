module Square
  module Connect
    module Connections
      module Refunds
        def refunds(params = nil)
          access_token_required!
          refunds = handle_response do
            access_token.get endpoint_for(identifier, :refunds), params
          end
          refunds.collect do |refund|
            Refund.new refund.merge(
              access_token: access_token
            )
          end
        end
      end
    end
  end
end