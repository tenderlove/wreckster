require 'helper'

module Wreckster
  class TestWreckster < Wreckster::TestCase
    def setup
      @url = 'http://localhost:8182/'
    end

    def test_traversals
      conn.responses << Response.new(traversal_response)

      graph = Wreckster::Graph.new('http://localhost:8182/')
      traversals = graph.traversals
      assert_equal 5, traversals.length
      assert_equal 0, conn.responses.length

      response = JSON.parse traversal_response
      assert_equal response['traversals'].sort, traversals.map { |t| t.name }.sort
    end
  end
end
