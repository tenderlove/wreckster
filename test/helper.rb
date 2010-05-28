require "test/unit"
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
end
