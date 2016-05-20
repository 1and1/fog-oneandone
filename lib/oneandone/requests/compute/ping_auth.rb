module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Returns "PONG" if API is running and your token is valid.
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#ping_auth_get]
        ##
        def ping_auth

          # Request
          params = {
            'method' => :get,
            'endpoint' => '/ping_auth'
          }

          request(params)

        end

      end # Real

      
      class Mock

        def ping_auth
          
          Fog::Mock.not_implemented

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog