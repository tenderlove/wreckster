require 'minitest/autorun'
require "wreckster"

module Wreckster
  class FakeConnector
    attr_accessor :last_url, :responses

    def initialize
      @last_url  = nil
      @responses = []
    end

    def request url
      @last_url = url
      @responses.pop
    end

  end
  Response = Struct.new(:body)
  Wreckster.connection = FakeConnector.new

  class TestCase < MiniTest::Unit::TestCase
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

    def rank_traversal
      '{"query_time":5,"score":58.0,"success":true}'
    end
  end
end
