module Square
  module Connect
    class Settlement < Node
      attr_accessor :status, :initiated_at, :bank_account, :total_money, :entries

      def initialize(*args)
        super do |attributes|
          self.status = attributes[:status]
          self.initiated_at = if attributes[:initiated_at]
            Time.parse attributes[:initiated_at]
          end
          self.bank_account = if attributes[:bank_account_id]
            BankAccount.new attributes[:bank_account_id], access_token
          end
          self.total_money = if attributes[:total_money]
            Money.new attributes[:total_money]
          end
          self.entries = Array(attributes[:entries]).collect do |entry_attributes|
            SettlementEntry.new entry_attributes
          end

          merchnat_id = attributes[:merchant_id] || :me
          self.endpoint = endpoint_for merchnat_id, :settlements, identifier
        end
      end
    end
  end
end