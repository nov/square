module Square
  module OAuth2
    class Client < Rack::OAuth2::Client
      def initialize(*options)
        attributes = options.extract_options!
        attributes[:identifier] ||= options.first
        attributes[:secret] ||= options.second
        attributes[:host] ||= 'squareup.com'
        super attributes
      end

      def access_token!(*args)
        super client_auth_method: :body
      end

      def renew!
        # TODO
      end

      private

      def handle_success_response(response)
        token_hash = JSON.parse(response.body).with_indifferent_access
        AccessToken.new token_hash
      end
    end
  end
end