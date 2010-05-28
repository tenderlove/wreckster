require 'helper'

module Wreckster
  class TestWreckster < Test::Unit::TestCase
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

    def test_traversal
      conn.responses << Response.new(find_response)

      t    = Wreckster::Traversal.new @url, 'grateful/co-follows-rank'
      objs = t.find('song.name' => 'SUGAREE', 'offset.end' => 2)

      assert_equal 2, objs.length
      assert_equal %w{ song song }, objs.map { |o| o.type }
      assert_equal [5.0, 8.0], objs.map { |o| o.rank }
    end

    def conn
      Wreckster.connection
    end

    def traversal_response
      <<-eojson
    {"query_time":0,"name":"Wreckster: A Graph-Based Ranking Engine","up_time":"0[d]:00[h]:54[m]:43[s]","traversals":["grateful\/singer-writer-rank","grateful\/follows-score","grateful\/co-follows-rank","gremlin","grateful\/artist-rank"]}
      eojson
    end

    def find_response
      <<-eojson
    {"ranks":[{"grateful\/co-follows-rank":5.0,"_id":"35","name":"WAY TO GO HOME","song_type":"original","performances":92,"type":"song"},{"grateful\/co-follows-rank":8.0,"_id":"36","name":"SAINT OF CIRCUMSTANCE","song_type":"original","performances":222,"type":"song"}],"query_time":1,"success":true,"size":2,"total_rank":2777.0}
      eojson
    end
  end
end
