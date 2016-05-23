module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Add servers to a private network
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#private_networks__private_network_id__servers_post]
        ##
        def add_private_network_servers(private_network_id: nil, servers: nil)
          
          # Build POST body
          new_servers = {
            'servers' => servers
          }

          # Clean out null keys in POST body
          body = clean_hash(new_servers)

          # Stringify the POST body
          string_body = Fog::JSON.encode(body)

          # Request
          params = {
            'method' => :post,
            'endpoint' => "/private_networks/#{private_network_id}/servers",
            'body' => string_body
          }

          request(params)

        end

      end # Real

      
      class Mock

        def add_private_network_servers(private_network_id: nil, servers: nil)
          
          # Search for private network to return
          if private_network = self.data[:private_networks].find {
            |hash| hash['id'] == private_network_id
          }
            # Add servers
            servers.each do |server|
              private_network['servers'] << server
            end
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 202
          response.body = private_network
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog