require 'helper'

class TestConfu < Test::Unit::TestCase
  context "Confu" do
    
    class TestConfuDude
      include Confu
      
      configuration do
        property :useless, :default => "useless"
        property :no_default
      end
    end
    
    setup do
      @tcd = TestConfuDude.new
      @config = @tcd.config
    end
    
    should "be able to be included in another class" do      
      assert_equal @config.useless, "useless"
    end
    
    should "have a nil value for a property without a default" do
      assert_nil @config.no_default
    end
    
    should "raise a NoMethodError  if the method isn't 'configured'" do
      assert_raises NoMethodError do
        @config.box_car
      end
    end
    
  end
end
