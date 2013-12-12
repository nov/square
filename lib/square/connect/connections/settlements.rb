module Square
  module Connect
    module Connections
      module Settlements
        def settlements(params = nil)
          access_token_required!
          settlements = handle_response do
            access_token.get endpoint_for(identifier, :settlements), params
          end
          settlements.collect do |settlement|
            Settlement.new settlement.merge(
              access_token: access_token
            )
          end
        end

        def settlement(settlement_id, params = nil)
          access_token_required!
          Settlement.new(
            settlement_id,
            merchant_id: identifier,
            access_token: access_token
          ).fetch
        end
      end
    end
  end
end