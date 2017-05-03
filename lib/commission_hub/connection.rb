module CommissionHub
  class Connection

    attr_reader :settings

    include HTTParty
    debug_output $stdout

    class << self

      def def_endpoint(name, uri=nil, options={})

        namespace   = "#{self.to_s.deconstantize}::Endpoints"

        klass = if options[:class]
          "#{namespace}::#{options[:class].to_s.camelcase.demodulize}"
        else
          "#{namespace}::#{name.to_s.singularize.camelcase}"
        end

        @endpoints ||= {}
        @endpoints[name.to_sym] = klass.constantize.new(uri)
        
        class_eval <<-METHODS, __FILE__, __LINE__
          def #{name}(extended_uri=nil, async: false, mapper: false, request_params: {})

            dispatch = lambda do
              
              endpoint = self.class.endpoints(__method__.to_sym)
              endpoint.connection = self
              endpoint.mapper = mapper
              endpoint.extend_uri(extended_uri)

              response = endpoint.call(request_params)
              payload = endpoint.mapper ? endpoint.mapper.call(response.body) : response.body
              
              if block_given?
                yield payload, response.code, response.headers
              else
                {body: payload, code: response.code, headers: response.headers}
              end

            end
            
           async ? Thread.new(&dispatch) : dispatch.call

          end
        METHODS

      end

      def endpoints(name=nil)
        name ? @endpoints[name] : @endpoints
      end

    end
    
  end
end
