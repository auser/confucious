$:.unshift(File.expand_path("confu", File.dirname(__FILE__)))
require 'hashie'
require 'logger'

require 'config'

module Confu

  # This allows us to do cool things like set our 
  # own configuration in a block
  def configure(opts={}, &block)
    mash = self.class.configure(&block)
    Config.defaults.merge!(mash)
    @config = nil # reset!
  end
  
  def configuration(&block)
    Confu::Config.instance_eval(&block) if block_given?
  end
  
  def config
    @config ||= Confu::Config.new
  end
  
  def self.included(mod)
    mod.extend self
  end
end