module Wreckster
  class Object
    attr_reader :identifier, :rank, :type

    def initialize traversal, properties
      @traversal  = traversal
      @properties = properties
      @identifier = properties['_id']
      @rank       = properties[traversal]
      @type       = properties['type']
    end

    def respond_to? key
      @properties.key?(key.to_s) || super
    end

    def method_missing key, *args
      return super unless respond_to? key
      @properties[key.to_s]
    end
  end
end
