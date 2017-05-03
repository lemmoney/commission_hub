module CommissionHub
  class Endpoint
      
    attr_accessor :name, :connection, :full_uri
    attr_writer   :mapper

    def initialize(uri) 
      @uri = uri
    end

    def extend_uri(ext_uri=nil)
      if @uri
        @full_uri = "#{connection.settings.base_uri.chomp("/")}/#{@uri}/#{ext_uri&.gsub("//","/")}".chomp("/")
      else
        @full_uri = "#{connection.settings.base_uri.chomp("/")}/#{ext_uri&.gsub("//","/")}".chomp("/")
      end
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
