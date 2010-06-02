require 'helper'

module Wreckster
  class TestTraversal < Wreckster::TestCase
    def setup
      super
      conn.responses << Response.new(find_response)

      @url  = 'http://localhost:8182/'
      @name = 'grateful/co-follows-rank'
      @t    = Wreckster::Traversal.new @url, @name
    end

    def test_traversal
      objs = @t.find('song.name' => 'SUGAREE', 'offset.end' => 2)

      assert_equal 2, objs.length
      assert_equal %w{ song song }, objs.map { |o| o.type }
      assert_equal [5.0, 8.0], objs.map { |o| o.rank }
    end

    def test_cgi_escape
      objs = @t.find('song.name' => 'Aaron Patterson', 'offset.end' => 2)

      assert_equal 2, objs.length
      assert_equal %w{ song song }, objs.map { |o| o.type }
      assert_equal [5.0, 8.0], objs.map { |o| o.rank }
    end
  end
end
