module CommissionHub
  module RakutenAffiliateNetworkV1
    class Connection < CommissionHub::Connection

      def_endpoint :authorization,   "token"
      def_endpoint :events,          "events/1.0/transactions", class: :Base
      def_endpoint :advertisers,     "advertisersearch/1.0",    class: :Base
      def_endpoint :links,           "linklocator/1.0",         class: :Base
      
      def initialize(settings)
        @settings = settings
      end

    end
  end
end

