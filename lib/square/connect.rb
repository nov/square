module Square
  module Connect
    ROOT_URL = 'https://connect.squareup.com/v1'
  end
end

require 'square/connect/error'
require 'square/connect/node'

require 'square/connect/device'
require 'square/connect/itemization'
require 'square/connect/money'
require 'square/connect/refund'
require 'square/connect/tax'
require 'square/connect/tender'