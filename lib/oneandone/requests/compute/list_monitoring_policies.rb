module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Returns a list of all monitoring policies on your account
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#monitoring_policies_get]
        ##
        def list_monitoring_policies(page: nil, per_page: nil, sort: nil, q: nil,
          fields: nil)
          
          # Build hash for query parameters
          keyword_args = {
            :page => page,
            :per_page => per_page,
            :sort => sort,
            :q => q,
            :fields => fields
          }

          # Clean out null query parameters
          query = clean_hash(keyword_args)

          # Request
          params = {
            'method' => :get,
            'endpoint' => '/monitoring_policies',
            'params' => query
          }

          request(params)

        end

      end # Real

      
      class Mock

        def list_monitoring_policies(page: nil, per_page: nil, sort: nil, q: nil,
          fields: nil)
          
          response = Excon::Response.new
          response.status = 200
          response.body = self.data[:monitoring_policies]
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog