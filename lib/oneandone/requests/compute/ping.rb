module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Returns "PONG" if API is running.
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#ping_get]
        ##
        def ping

          # Request
          params = {
            'method' => :get,
            'endpoint' => '/ping'
          }

          request(params)

        end

      end # Real

      
      class Mock

        def ping
          
          Fog::Mock.not_implemented

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog