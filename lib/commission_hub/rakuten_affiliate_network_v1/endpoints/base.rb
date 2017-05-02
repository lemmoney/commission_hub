module CommissionHub
  module RakutenAffiliateNetworkV1
    module Endpoints
      class Base < CommissionHub::Endpoint
        
        include CommissionHub::RakutenAffiliateNetworkV1::ApiAccess

        def call(request_params={})
          request_params = { headers: { "Authorization" => bearer_token }}.merge(request_params)
          connection.class.get(uri, request_params)
        end

      end
    end
  end
end

