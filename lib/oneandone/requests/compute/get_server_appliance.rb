module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Returns information about a server appliance
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#server_appliances__id__get]
        ##
        def get_server_appliance(appliance_id)
          
          params = {
            'method' => :get,
            'endpoint' => "/server_appliances/#{appliance_id}"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def get_server_appliance(appliance_id)
          
          # Search for server appliance to return
          if server_appliance = self.data[:server_appliances].find {
            |hash| hash['id'] == appliance_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 200
          response.body = server_appliance
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog