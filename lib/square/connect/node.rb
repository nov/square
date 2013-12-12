module Square
  module Connect
    class Node
      attr_accessor :identifier, :endpoint, :access_token

      def initialize(*args)
        attributes = args.extract_options!
        self.identifier = attributes[:id] || attributes[:identifier] || args.first
        self.access_token = tokenize attributes[:access_token] || args.second
        yield attributes if block_given?
        self.endpoint ||= endpoint_for identifier
      end

      def fetch
        access_token_required!
        attributes = handle_response do
          access_token.get endpoint
        end
        self.class.new attributes.merge(
          access_token: access_token
        )
      end

      private

      def access_token_required!
        raise Exception.new('access_token required') unless access_token
      end

      def endpoint_for(*path_elements)
        File.join ROOT_URL, *path_elements.collect(&:to_s)
      end

      def tokenize(access_token)
        case access_token
        when OAuth2::AccessToken
          access_token
        when String
          OAuth2::AccessToken.new access_token
        end
      end

      def handle_response
        response = yield
        case response.status
        when 200..201
          handle_success_response response
        else
          handle_error_response response
        end
      end

      def handle_success_response(response)
        parse_json response.body
      end

      def handle_error_response(response)
        error = parse_json response.body
        raise Error.new(response.status, error)
      end

      def parse_json(raw_json)
        json = MultiJson.load(raw_json)
        case json
        when Hash
          json.with_indifferent_access
        when Array
          json.collect(&:with_indifferent_access)
        else
          {}
        end
      end
    end
  end
end