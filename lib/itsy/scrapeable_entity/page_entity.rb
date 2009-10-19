module Itsy
  class ScrapeableEntity
    class PageEntity < ScrapeableEntity
      attr_reader :url
      def initialize(url)
        @url = url
        super
      end
  
      def get
        full_url = @url =~ /^http:\/\// ? @url : "#{FutureBusinessParser::HOST}#{@url}"
        @doc = Hpricot(open(URI.parse(full_url)))
      end
    end
  end
end