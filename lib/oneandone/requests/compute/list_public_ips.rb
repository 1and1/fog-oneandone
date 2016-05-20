module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Returns a list of all public IPs on your account
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#public_ips_get]
        ##
        def list_public_ips(page: nil, per_page: nil, sort: nil, q: nil,
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
            'endpoint' => '/public_ips',
            'params' => query
          }

          request(params)

        end

      end # Real

      
      class Mock

        def list_public_ips(page: nil, per_page: nil, sort: nil, q: nil,
          fields: nil)
          
          response = Excon::Response.new
          response.status = 200
          response.body = self.data[:public_ips]
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog