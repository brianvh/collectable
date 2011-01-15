require 'active_support/core_ext'

require 'collectable/collector'
module Collectable
  def self.included(receiver)
    receiver.extend Collectable::Collector
  end
end
