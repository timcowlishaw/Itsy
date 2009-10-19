module Itsy
  class ScrapeableEntity
    class ElementEntity < ScrapeableEntity
      def initialize(element)
        @doc = element
        super
      end
    end
  end
end