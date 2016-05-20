module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Modify a public IP
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#public_ips__ip_id__put]
        ##
        def update_public_ip(ip_id: nil, reverse_dns: nil)
          
          # Build PUT body
          update_ip = {
            'reverse_dns' => reverse_dns
          }

          # Stringify the PUT body
          string_body = Fog::JSON.encode(update_ip)

          # Request
          params = {
            'method' => :put,
            'endpoint' => "/public_ips/#{ip_id}",
            'body' => string_body
          }

          request(params)

        end

      end # Real

      
      class Mock

        def update_public_ip(ip_id: nil, reverse_dns: nil)
          
          # Search for IP to update
          if ip = self.data[:public_ips].find {
            |hash| hash['id'] == ip_id
          }
            # Create parameter hash 
            params = {
              'reverse_dns' => reverse_dns
            }
            
            # Update the IP we found with new values
            params.each do |key, value|
              if value
                ip[key] = value
              end
            end
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 202
          response.body = ip
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog