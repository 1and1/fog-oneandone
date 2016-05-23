module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Modify a firewall policy
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#firewall_policies__firewall_id__put]
        ##
        def update_firewall(firewall_id: nil, name: nil, description: nil)
          
          # Build POST body
          new_firewall = {
            'name' => name,
            'description' => description
          }

          # Clean out null keys in POST body
          body = clean_hash(new_firewall)

          # Stringify the POST body
          string_body = Fog::JSON.encode(body)

          # Request
          params = {
            'method' => :put,
            'endpoint' => "/firewall_policies/#{firewall_id}",
            'body' => string_body
          }

          request(params)

        end

      end # Real

      
      class Mock

        def update_firewall(firewall_id: nil, name: nil, description: nil)
          
          # Search for firewall to update
          if firewall = self.data[:firewalls].find {
            |hash| hash['id'] == firewall_id
          }
            # Create parameter hash 
            params = {
              'name' => name,
              'description' => description
            }
            
            # Update the firewall we found with new values
            params.each do |key, value|
              if value
                firewall[key] = value
              end
            end
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 202
          response.body = firewall
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog