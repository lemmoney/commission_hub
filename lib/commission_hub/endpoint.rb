module CommissionHub
  class Endpoint
      
    attr_accessor :name, :connection
    attr_writer   :mapper

    def initialize(uri) 
      @uri = uri
    end

    def uri(extended_uri=nil)
      "#{connection.settings.base_uri.chomp("/")}/#{@uri}/#{extended_uri&.gsub("//","/")}".chomp("/")
    end

    def mapper
      return nil unless @mapper
      if (@mapper.kind_of?(String) || @mapper.kind_of?(Symbol))
        return @mapper.constantize.new
      elsif @mapper.kind_of? Proc
        return @mapper
      else
        return @mapper.new
      end
    end

  end
end
