module Delegation
  def self.included(base)
    base.extend ClassMethods
  end
  module ClassMethods
      def delegate(hash)
      hash.each do |methods, variable|
        methods = [methods] unless methods.is_a?(Array)
        methods.each do |method|
          class_eval <<-EOS
            def #{method}(*a, &b)
              #{variable}.#{method}(*a, &b)
            end
          EOS
        end
      end
    end
  end
end
