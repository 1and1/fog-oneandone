module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Returns a list of appliances that you can use to create a server
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#server_appliances_get]
        ##
        def list_server_appliances(page: nil, per_page: nil, sort: nil, q: nil,
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
            'endpoint' => '/server_appliances',
            'params' => query
          }

          request(params)

        end

      end # Real

      
      class Mock

        def list_server_appliances(page: nil, per_page: nil, sort: nil, q: nil,
          fields: nil)
          
          response = Excon::Response.new
          response.status = 200
          response.body = self.data[:server_appliances]
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog