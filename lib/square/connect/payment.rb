module Square
  module Connect
    class Payment < Node
      attr_accessor(
        :merchant,
        :created_at,
        :creator,
        :description,
        :device,
        :inclusive_tax_money,
        :additive_tax_money,
        :tax_money,
        :tip_money,
        :discount_money,
        :total_collected_money,
        :processing_fee_money,
        :net_total_money,
        :refunded_money,
        :inclusive_tax,
        :additive_tax,
        :tender,
        :refunds,
        :itemizations
      )
    end
  end
end