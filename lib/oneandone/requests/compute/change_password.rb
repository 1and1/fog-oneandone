module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Returns the credentials for accessing the shared storages
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#shared_storages_access_get]
        ##
        def change_password(password)
          
          # Create PUT body
          new_password = {
            'password' => password
          }

          # Stringify the PUT body
          string_body = Fog::JSON.encode(new_password)

          # Request
          params = {
            'method' => :put,
            'endpoint' => '/shared_storages/access',
            'body' => string_body
          }

          request(params)

        end

      end # Real

      
      class Mock

        def change_password(password)
          Fog::Mock.not_implemented
        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog