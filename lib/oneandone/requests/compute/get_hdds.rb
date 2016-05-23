module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # List a server's HDD's
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#servers__server_id__hardware_hdds_get]
        ##
        def get_hdds(server_id)
          
          params = {
            'method' => :get,
            'endpoint' => "/servers/#{server_id}/hardware/hdds"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def get_hdds(server_id)
          
          # Search for server
          if server = self.data[:servers].find {
            |hash| hash['id'] == server_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 200
          response.body = server['hardware']['hdds']
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog