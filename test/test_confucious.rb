require 'helper'

class TestConfucious < Test::Unit::TestCase
  context "Confucious" do
    
    class TestConfuciousDude
      include Confucious
      
      configuration do
        property :useless, :default => "useless"
        property :no_default
        property :never_set_with_a_default
      end
    end
    
    setup do
      @tcd = TestConfuciousDude.new
      @config = @tcd.config
    end
    
    should "be able to set configuration" do
      TestConfuciousDude.configure do |c|
        c.no_default = "this is a value"
      end
      
      assert_equal "this is a value", TestConfuciousDude.new.config.no_default
    end
    
    should "be able to be included in another class" do      
      assert_equal @config.useless, "useless"
    end
    
    should "have a nil value for a property without a default" do
      assert_nil @config.never_set_with_a_default
    end
    
    should "raise a NoMethodError  if the method isn't 'configured'" do
      assert_raises NoMethodError do
        @config.box_car
      end
    end
        
    should "only create one instance of config" do
      assert_equal @config, TestConfuciousDude.new.config
    end
    
  end
end
