module Wreckster
  class Graph
    def initialize url
      @url     = url
      @payload = nil
    end

    def traversals
      t = payload['traversals']
      t = t.keys if Hash === t
      t.map { |name| Traversal.new(@url, name) }
    end

    private
    def payload
      @payload ||= JSON.parse Wreckster.connection.request(URI.parse(@url)).body
    end
  end
end
