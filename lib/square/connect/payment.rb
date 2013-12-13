module Square
  module Connect
    class Payment < Node
      attr_accessor(
        :merchant,
        :creator,
        :created_at,
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

      def initialize(*args)
        super do |attributes|
          self.merchant = if attributes[:merchant_id]
            Merchant.new attributes[:merchant_id], access_token
          else
            Merchant.me access_token
          end
          self.creator = if attributes[:creator_id]
            Merchant.new attributes[:creator_id], access_token
          end
          self.created_at = if attributes[:created_at]
            Time.parse attributes[:created_at]
          end
          self.description = attributes[:description]
          self.device = if attributes[:device]
            Device.new attributes[:device]
          end
          [
            :inclusive_tax_money,
            :additive_tax_money,
            :tax_money,
            :tip_money,
            :discount_money,
            :total_collected_money,
            :processing_fee_money,
            :net_total_money,
            :refunded_money
          ].each do |money_key|
            if attributes[money_key]
              self.send "#{money_key}=", Money.new(attributes[money_key])
            end
          end
          [
            :inclusive_tax,
            :additive_tax
          ].each do |tax_key|
            taxes = Array(attributes[tax_key]).collect do |tax_attributes|
              Tax.new tax_attributes
            end
            self.send "#{tax_key}=", taxes
          end
          self.tender = Array(attributes[:tender]).collect do |tender_attributes|
            Tender.new tender_attributes
          end
          self.refunds = Array(attributes[:refunds]).collect do |refund_attributes|
            Refund.new refund_attributes
          end
          self.itemizations = Array(attributes[:itemizations]).collect do |itemization_attributes|
            Itemization.new itemization_attributes
          end
          self.endpoint = endpoint_for merchant.identifier, :payments, identifier
        end
      end
    end
  end
end