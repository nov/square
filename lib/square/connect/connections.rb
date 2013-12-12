module Square
  module Connect
    module Connections
    end
  end
end

Dir[File.dirname(__FILE__) + '/connections/*.rb'].each do |file|
  require file
end