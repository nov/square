# Square

Square API Client

https://connect.squareup.com

## Installation

Add this line to your application's Gemfile:

    gem 'square'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install square

## Usage

### OAuth 2.0

    client = Square::OAuth2::Client.new(
      '<your-client-id>',
      redirect_uri: 'https://example.client.com/callback'
    )

    ## Authorization Request
    redirect_to client.authorization_uri

    ## Token Request
    client.authorization_code = '<your-authorization-code>'
    access_token = client.access_token!

### Connect API

    me = Square::Connect::Merchant.me access_token

    ## Merchant API
    me = me.fetch

    ## Payments API
    payments = me.payments

    ## Payment API
    payment = me.payment '<payment-id>'

    ## Refunds API
    refunds = me.refunds

    ## Settlements API
    settlements = me.settlements

    ## Settlement API
    settlement = me.settlement '<settlement-id>'

    ## Bank Account API
    bank_account = me.bank_account '<bank-accout-id>'

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
