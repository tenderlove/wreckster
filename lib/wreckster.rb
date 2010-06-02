require 'json'
require 'net/http'
require 'net/http/persistent'
require 'uri'
require 'wreckster/graph'
require 'wreckster/traversal'
require 'wreckster/object'

module Wreckster
  VERSION = '1.0.1'

  @connection = Net::HTTP::Persistent.new
  class << self
    attr_accessor :connection
  end
end
