module Confucious
  class Config < Hashie::Dash
    
    property :logger, :default => ::Logger.new(STDOUT)
    
  end
end