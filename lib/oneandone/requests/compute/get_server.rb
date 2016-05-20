module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Returns information about a server
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#servers__server_id__get]
        ##
        def get_server(server_id)
          
          params = {
            'method' => :get,
            'endpoint' => "/servers/#{server_id}"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def get_server(server_id)
          
          # Search for server to return
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
          response.body = server
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog