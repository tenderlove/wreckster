require 'cgi'

module Wreckster
  class Traversal
    attr_reader :name

    def initialize base, name
      @base = base
      @name = name
    end

    def find options = {}
      params = options.map { |k,v| "#{k}=#{CGI.escape(v.to_s)}" }.join("&")
      map = JSON.parse(
        Wreckster.connection.request(URI.parse(url + "?#{params}")).body
      )
      return map['score'] if map.key?('score')

      map['ranks'].map { |thing| Wreckster::Object.new(name, thing) }
    end

    def info
      JSON.parse Net::HTTP.get(URI.parse(url))
    end

    def url
      @base + @name
    end
  end
end
