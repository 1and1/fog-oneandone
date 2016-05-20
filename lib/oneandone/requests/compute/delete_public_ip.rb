module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Delete a public IP
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#public_ips__ip_id__delete]
        ##
        def delete_public_ip(ip_id)
          
          params = {
            'method' => :delete,
            'endpoint' => "/public_ips/#{ip_id}"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def delete_public_ip(ip_id)
          
          # Search for public IP to destroy
          if ip = self.data[:public_ips].find {
            |hash| hash['id'] == ip_id
          }
            self.data[:public_ips].delete(ip)
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 202
          response.body = 'The requested public IP has been deleted.'
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog