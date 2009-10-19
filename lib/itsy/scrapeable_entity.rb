module Itsy
  class ScrapeableEntity
    include Delegation
    delegate [:each,:to_json] => :values
    include Enumerable
    attr_reader :doc
    
    class << self
      attr_reader :properties
      def has_property(name, selector, opts={}, &postprocess)
        @properties ||= []
        attr_reader name
        @properties << [name, selector, opts, postprocess]
      end
      
      def html_decode(string)
        @html_coder ||= HTMLEntities.new
        @html_coder.decode(string.gsub('&nbsp;', ''))
      end
    end
    
    
    def initialize(initial)
      self.class.properties.each do |name, selector, opts, postprocess|
        self.instance_variable_set("@#{name}", []) if opts.include?(:collection) 
      end     
      get
      parse
    end
    
     def parse
        raise "Can't parse without first getting the document" unless doc
        self.class.properties.each do |name, selector, opts, postprocess|
          elem = selector ? doc.search(selector) : doc
          value = postprocess ? postprocess.call(elem) : elem
          if opts[:class]
            value = opts[:collection] ?  value.map {|e| opts[:class].new(e) } :  opts[:class].new(value)
          end
          if opts[:collection] && !value.is_a?(Array)
            self.send(name) << value
          else
            self.instance_variable_set("@#{name}", value)
          end
        end
      end

      def values 
        self.class.properties.transpose[0].map_to_hash do |key|
          value = self.send(key)
          value = value.values if value.is_a?(ScrapeableEntity)
          value = value.map {|v| v.is_a?(ScrapeableEntity) ? v.values : v } if value.is_a?(Array)
          {key => value}
        end
      end
    
    def get
      nil
    end
  
  end
end