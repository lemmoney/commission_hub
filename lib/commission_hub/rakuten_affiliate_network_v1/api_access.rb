module CommissionHub
  module RakutenAffiliateNetworkV1
    module ApiAccess
      
      private
      
      def full_uri
        "#{connection.settings.base_url}/#{base_uri}"
      end

      def bearer_token
        connection.settings.authorization_bearer_token
      end

    end
  end
end
