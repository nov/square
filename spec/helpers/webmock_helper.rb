require 'webmock/rspec'

module WebMockHelper
  def mock_request(path_or_uri, response_file, options = {})
    method = options[:method] || :get
    endpoint = endpoint_for(path_or_uri)
    stub_request(method, endpoint).with(
      request_for(method, options)
    ).to_return(
      response_for(response_file, options)
    )
    if block_given?
      response = yield
      a_request(method, endpoint).with(
        request_for(method, options)
      ).should have_been_made.once
      response
    end
  end

  private

  def endpoint_for(path_or_uri)
    if path_or_uri =~ /^https?:\/\//
      path_or_uri
    else
      File.join Square::Connect::ROOT_URL, path_or_uri
    end
  end

  def request_for(method, options = {})
    request = {}
    if options[:params]
      case method
      when :post, :put
        request[:body] = options[:params]
      else
        request[:query] = options[:params]
      end
    end
    if options[:request_header]
      request[:headers] = options[:request_header]
    end
    request
  end

  def response_for(response_file, options = {})
    response = {}
    response[:body] = File.new File.join(File.dirname(__FILE__), '../mock_response', "#{response_file}.json")
    if options[:status]
      response[:status] = options[:status]
    end
    response
  end
end

include WebMockHelper
WebMock.disable_net_connect!