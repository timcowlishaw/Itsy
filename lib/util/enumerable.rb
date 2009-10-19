module Enumerable
  def map_to_hash(&block) 
    self.inject({}) {|m, o| m.merge!(block.call(o))}
  end
end