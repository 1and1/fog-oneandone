module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Returns information about a VPN
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#vpns__vpn_id__get]
        ##
        def get_vpn(vpn_id)
          
          params = {
            'method' => :get,
            'endpoint' => "/vpns/#{vpn_id}"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def get_vpn(vpn_id)
          
          # Search for VPN to return
          if vpn = self.data[:vpns].find {
            |hash| hash['id'] == vpn_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 200
          response.body = vpn
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog