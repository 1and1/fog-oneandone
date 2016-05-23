module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Remove a server from a private network
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#servers__server_id__private_networks__private_network_id__delete]
        ##
        def remove_private_network(server_id: nil, private_network_id: nil)
          
          params = {
            'method' => :delete,
            'endpoint' => "/servers/#{server_id}/private_networks/#{private_network_id}"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def remove_private_network(server_id: nil, private_network_id: nil)
          
          # Search for server
          if server = self.data[:servers].find {
            |hash| hash['id'] == server_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Search for private network
          if private_network = server['private_networks'].find {
            |hash| hash['id'] == private_network_id
          }
            server['private_networks'].delete(private_network)
          else
            raise Fog::Errors::NotFound.new('The requested private network could
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