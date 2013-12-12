module Square
  module OAuth2
    class AccessToken < Rack::OAuth2::AccessToken::Bearer
      def initialize(*options)
        attributes = options.extract_options!
        attributes[:access_token] ||= options.first
        super attributes
      end
    end
  end
end
