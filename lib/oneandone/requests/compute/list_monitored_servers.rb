module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Lists usages and alerts of monitoring servers
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#monitoring_center_get]
        ##
        def list_monitored_servers(page: nil, per_page: nil, sort: nil, q: nil,
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
            'endpoint' => '/monitoring_center',
            'params' => query
          }

          request(params)

        end

      end # Real

      
      class Mock

        def list_monitored_servers(page: nil, per_page: nil, sort: nil, q: nil,
          fields: nil)
          Fog::Mock.not_implemented
        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog