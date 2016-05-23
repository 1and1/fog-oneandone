module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Delete a VPN
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#vpns__vpn_id__delete]
        ##
        def delete_vpn(vpn_id)
          
          params = {
            'method' => :delete,
            'endpoint' => "/vpns/#{vpn_id}"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def delete_vpn(vpn_id)
          
          # Search for VPN to delete
          if vpn = self.data[:vpns].find {
            |hash| hash['id'] == vpn_id
          }
            self.data[:vpns].delete(vpn)
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 202
          response.body = 'The requested VPN has been deleted.'
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog