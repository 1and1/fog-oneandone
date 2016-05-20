module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Returns information about a server's status
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#servers__server_id__status_get]
        ##
        def status(server_id)
          
          params = {
            'method' => :get,
            'endpoint' => "/servers/#{server_id}/status"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def status(server_id)
          
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
          response.body = server['status']
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog