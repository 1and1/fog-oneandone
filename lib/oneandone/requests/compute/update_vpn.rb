module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Modify a VPN
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#vpns__vpn_id__put]
        ##
        def update_vpn(vpn_id: nil, name: nil, description: nil)

          # Build PUT body
          new_vpn = {
            'name' => name,
            'description' => description
          }

          # Clean out null values from PUT body
          body = clean_hash(new_vpn)

          # Stringify the PUT body
          string_body = Fog::JSON.encode(body)

          # Request
          params = {
            'method' => :put,
            'endpoint' => "/vpns/#{vpn_id}",
            'body' => string_body
          }

          request(params)

        end

      end # Real

      
      class Mock

        def update_vpn(vpn_id: nil, name: nil, description: nil)
          
          # Search for VPN to update
          if vpn = self.data[:vpns].find {
            |hash| hash['id'] == vpn_id
          }
            # Create parameter hash 
            params = {
              'name' => name,
              'description' => description
            }
            
            # Update the VPN we found with new values
            params.each do |key, value|
              if value
                vpn[key] = value
              end
            end
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 202
          response.body = vpn
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog