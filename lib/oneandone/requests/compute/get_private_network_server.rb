module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Returns information about a private network's server
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#private_networks__private_network_id__servers__server_id__get]
        ##
        def get_private_network_server(private_network_id: nil, server_id: nil)
          
          params = {
            'method' => :get,
            'endpoint' => "/private_networks/#{private_network_id}/servers/#{server_id}"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def get_private_network_server(private_network_id: nil, server_id: nil)
          
          # Search for private network
          if private_network = self.data[:private_networks].find {
            |hash| hash['id'] == private_network_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Search for server to return
          if server = private_network['servers'].find {
            |index| index == server_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested server could
            not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 202
          response.body = server
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog