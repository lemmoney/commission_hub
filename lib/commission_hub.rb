require "singleton"
require "ostruct"
require "httparty"
require 'nokogiri'
require "active_support/inflector"

require "commission_hub/version"
require "commission_hub/settings"
require "commission_hub/endpoint"
require "commission_hub/connection"

# # require "commission_hub/rakuten_affiliate_network_v1/api_access"
# # require "commission_hub/rakuten_affiliate_network_v1/endpoints/base"
# # require "commission_hub/rakuten_affiliate_network_v1/endpoints/authorization"
# # require "commission_hub/rakuten_affiliate_network_v1/connection"
# # require "commission_hub/rakuten_affiliate_network_v1/settings"

# require "commission_hub/commission_junction_v3/endpoints/base"
# require "commission_hub/commission_junction_v3/connection"
# require "commission_hub/commission_junction_v3/settings"

module CommissionHub

  class << self

    def setup(options={},&blk)
      @settings = CommissionHub::Settings.instance
      @settings.instance_eval &blk
      @settings
    end

    def initialize_connection(client, local_settings=nil)
      klass = "CommissionHub::#{client.to_s.camelcase}::Connection".constantize
      klass.new(set_local_settings_for(client, local_settings))
    end

    def set_local_settings_for(client, settings)
      if settings.kind_of? Hash
        settings.each do |k,v|
          settings_for(client).send("#{k}=",v)
        end
      elsif settings.kind_of? Proc
        settings_for(client).instance_eval &settings
      end
      settings_for(client)
    end

    def settings_for(client)
      CommissionHub::Settings.instance.setup(client)
    end

  end

end
