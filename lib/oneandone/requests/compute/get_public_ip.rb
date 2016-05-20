module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Returns information about a public IP
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#public_ips__ip_id__get]
        ##
        def get_public_ip(ip_id)
          
          params = {
            'method' => :get,
            'endpoint' => "/public_ips/#{ip_id}"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def get_public_ip(ip_id)
          
          # Search for IP to return
          if public_ip = self.data[:public_ips].find {
            |hash| hash['id'] == ip_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 200
          response.body = public_ip
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog