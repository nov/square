module Square
  module Connect
    ROOT_URL = 'https://connect.squareup.com/v1'
  end
end

require 'square/connect/error'
require 'square/connect/node'
require 'square/connect/connections'

require 'square/connect/bank_account'
require 'square/connect/merchant'
require 'square/connect/payment'
require 'square/connect/settlement'

require 'square/connect/device'
require 'square/connect/itemization'
require 'square/connect/money'
require 'square/connect/refund'
require 'square/connect/tax'
require 'square/connect/tender'