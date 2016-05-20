module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Create a new private network
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#private_networks_post]
        ##
        def create_private_network(name: nil, description: nil,
          network_address: nil, subnet_mask: nil, datacenter_id: nil)
          
          # Build POST body
          new_private_network = {
            'name' => name,
            'description' => description,
            'network_address' => network_address,
            'subnet_mask' => subnet_mask,
            'datacenter_id' => datacenter_id
          }

          # Clean out null keys in POST body
          body = clean_hash(new_private_network)

          # Stringify the POST body
          string_body = Fog::JSON.encode(body)

          # Request
          params = {
            'method' => :post,
            'endpoint' => '/private_networks',
            'body' => string_body
          }

          request(params)

        end

      end # Real

      
      class Mock

        def create_private_network(name: nil, description: nil,
          network_address: nil, subnet_mask: nil, datacenter_id: nil)
          
          # Create mock private network hash
          mock_private_network = {
            "id" => Fog::UUID.uuid,
            "name" => name,
            "description" => description,
            "datacenter" => {
              "id" => datacenter_id,
              "location" => "USA",
              "country_code" => "US"
            },
            "network_address" => network_address,
            "subnet_mask" => subnet_mask,
            "state" => "ACTIVE",
            "creation_date" => "2015-05-04T08:35:12+00:00",
            "servers" => [],
            "cloudpanel_id" => "pn99AA4_2"
          }

          # Save mock private network to list
          self.data[:private_networks] << mock_private_network

          # Return mock response to user
          response = Excon::Response.new
          response.status = 202
          response.body = mock_private_network
            
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog