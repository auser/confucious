$:.unshift(File.expand_path("confu", File.dirname(__FILE__)))
require 'hashie'
require 'logger'

require 'config'

module Confu
  module ClassMethods
    # This allows us to do cool things like set our 
    # own configuration in a block
    # 
    # Usage:
    #  [Module].configure do
    #     
    # end
    def configure(opts={}, &block)
      @config = nil # reset!
      mash = Hashie::Mash.new(opts)
      yield mash if block_given?
      Confu::Config.defaults.merge!(mash)
    end

    def configuration(&block)
      Confu::Config.instance_eval(&block) if block_given?
    end
    
    def config
      @config ||= Confu::Config.new
    end
  end
  
  module InstanceMethods
    def config
      self.class.config
    end
    
  end
  
  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end
