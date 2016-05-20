module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Creates a new VPN
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#vpns_post]
        ##
        def create_vpn(name: nil, description: nil, datacenter_id: nil)

          # Build POST body
          new_vpn = {
            'name' => name,
            'description' => description,
            'datacenter_id' => datacenter_id
          }

          # Clean out null values from POST body
          body = clean_hash(new_vpn)

          # Stringify the POST body
          string_body = Fog::JSON.encode(body)

          # Request
          params = {
            'method' => :post,
            'endpoint' => '/vpns',
            'body' => string_body
          }

          request(params)

        end

      end # Real

      
      class Mock

        def create_vpn(name: nil, description: nil, datacenter_id: nil)
          
          # Create mock vpn hash
          mock_vpn = {
            "id" => Fog::UUID.uuid,
            "name" => name,
            "description" => description,
            "state" => "ACTIVE",
            "datacenter" => {
              "id" => datacenter_id,
              "location" => "Spain",
              "country_code" => "ES"
            },
            "type" => "SSL",
            "ips" => [
              "10.131.1.45",
              "10.131.0.45"
            ],
            "cloudpanel_id" => "FW99AA4_8",
            "creation_date" => "30-06-2015T 14:52:35+00.00"
          }

          # Save mock vpn to vpns list
          self.data[:vpns] << mock_vpn

          # Return mock response to user
          response = Excon::Response.new
          response.status = 202
          response.body = mock_vpn
            
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog