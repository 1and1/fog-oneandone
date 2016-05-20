module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Assigns a private network to the server
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#servers__server_id__private_networks_post]
        ##
        def add_private_network(server_id: nil, private_network_id: nil)
          
          # Build PUT body
          private_network_specs = {
            'id' => private_network_id
          }

          # Stringify the PUT body
          string_body = Fog::JSON.encode(private_network_specs)

          # Request
          params = {
            'method' => :post,
            'endpoint' => "/servers/#{server_id}/private_networks",
            'body' => string_body
          }

          request(params)

        end

      end # Real

      
      class Mock

        def add_private_network(server_id: nil, private_network_id: nil)
          
          # Search for server
          if server = self.data[:servers].find {
            |hash| hash['id'] == server_id
          }
            private_network = {
              'id' => private_network_id
            }

            server['private_networks'] << private_network
          else
            raise Fog::Errors::NotFound.new('The requested resource could
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