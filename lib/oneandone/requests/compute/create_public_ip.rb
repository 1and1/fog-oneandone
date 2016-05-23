module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Create a new public IP
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#public_ips_post]
        ##
        def create_public_ip(reverse_dns: nil, type: nil, datacenter_id: nil)
          
          # Build POST body
          new_ip = {
            'reverse_dns' => reverse_dns,
            'type' => type,
            'datacenter_id' => datacenter_id
          }

          # Clean out null keys in POST body
          body = clean_hash(new_ip)

          # Stringify the POST body
          string_body = Fog::JSON.encode(body)

          # Request
          params = {
            'method' => :post,
            'endpoint' => '/public_ips',
            'body' => string_body
          }

          request(params)

        end

      end # Real

      
      class Mock

        def create_public_ip(reverse_dns: nil, type: nil, datacenter_id: nil)
          
          # Create mock public ip hash
          mock_public_ip = {
            "id" => Fog::UUID.uuid,
            "ip" => "10.4.140.155",
            "type" => type,
            "datacenter" => {
              "id" => datacenter_id,
              "location" => "USA",
              "country_code" => "US"
            },
            "assigned_to" => nil,
            "reverse_dns" => reverse_dns,
            "is_dhcp" => false,
            "state" => "ACTIVE",
            "creation_date" => "2015-05-06T08:17:33+00:00"
          }

          # Save mock public ip to list
          self.data[:public_ips] << mock_public_ip

          # Return mock response to user
          response = Excon::Response.new
          response.status = 202
          response.body = mock_public_ip
            
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog