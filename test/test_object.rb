require 'helper'

module Wreckster
  class TestObject < Wreckster::TestCase
    def test_identifier
      obj = Wreckster::Object.new 'foo', '_id' => 100
      assert_equal 100, obj.identifier
    end

    def test_rank
      obj = Wreckster::Object.new 'foo', 'foo' => 100
      assert_equal 100, obj.rank
    end

    def test_type
      obj = Wreckster::Object.new 'foo', 'type' => 'america'
      assert_equal 'america', obj.type
    end

    def test_responds_to?
      obj = Wreckster::Object.new 'foo', 'hello' => 'world'
      assert obj.respond_to?(:hello), 'responds to hello'
      assert !obj.respond_to?(:world), 'does not respond to world'
    end

    def test_method_missing
      obj = Wreckster::Object.new 'foo', 'hello' => 'world'
      assert_equal 'world', obj.hello
      assert_raises(NoMethodError) { obj.world }
    end
  end
end
