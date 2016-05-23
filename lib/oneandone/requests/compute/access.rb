module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Returns the credentials for accessing the shared storages
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#shared_storages_access_get]
        ##
        def access
          
          params = {
            'method' => :get,
            'endpoint' => '/shared_storages/access'
          }

          request(params)

        end

      end # Real

      
      class Mock

        def access
          Fog::Mock.not_implemented
        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog