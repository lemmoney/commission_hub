module CommissionHub
  module RakutenAffiliateNetworkV1
    module Endpoints
      class Authorization < CommissionHub::Endpoint
        
        def call(request_params)
          connection.class.post(uri, headers: { 'Authorization' => basic_auth }, body: credentials)
        end

        private

        def credentials
          {
            username:   connection.settings.username,
            password:   connection.settings.password,
            scope:      connection.settings.scope,
            client_id:  connection.settings.client_id,
            grant_type: 'password'
          }
        end

        def basic_auth
          connection.settings.authorization_basic_auth
        end

      end
    end
  end
end

