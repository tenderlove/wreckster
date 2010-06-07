require 'helper'

module Wreckster
  class TestScoreTraversal < Wreckster::TestCase
    def setup
      super
      conn.responses << Response.new(rank_traversal)

      @url  = 'http://localhost:8182/'
      @name = 'grateful/follows-score'
      @t    = Wreckster::Traversal.new @url, @name
    end

    def test_traversal
      score = @t.find('song.name' => 'SUGAREE')
      assert_equal 58.0, score
    end
  end
end
