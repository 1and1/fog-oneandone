module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Modify a private network
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#private_networks__private_network_id__put]
        ##
        def update_private_network(private_network_id: nil, name: nil,
          description: nil, network_address: nil, subnet_mask: nil)
          
          # Build PUT body
          new_private_network = {
            'name' => name,
            'description' => description,
            'network_address' => network_address,
            'subnet_mask' => subnet_mask
          }

          # Clean out null keys in PUT body
          body = clean_hash(new_private_network)

          # Stringify the PUT body
          string_body = Fog::JSON.encode(body)

          # Request
          params = {
            'method' => :put,
            'endpoint' => "/private_networks/#{private_network_id}",
            'body' => string_body
          }

          request(params)

        end

      end # Real

      
      class Mock

        def update_private_network(private_network_id: nil, name: nil,
          description: nil, network_address: nil, subnet_mask: nil)
          
          # Search for private network to update
          if private_network = self.data[:private_networks].find {
            |hash| hash['id'] == private_network_id
          }
            # Create parameter hash 
            params = {
              'name' => name,
              'description' => description,
              'network_address' => network_address,
              'subnet_mask' => subnet_mask,
            }
            
            # Update the private network we found with new values
            params.each do |key, value|
              if value
                private_network[key] = value
              end
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