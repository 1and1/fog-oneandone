module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Delete a firewall policy
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#firewall_policies__firewall_id__delete]
        ##
        def delete_firewall(firewall_id)
          
          params = {
            'method' => :delete,
            'endpoint' => "/firewall_policies/#{firewall_id}"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def delete_firewall(firewall_id)
          
          # Search for firewall to destroy
          if firewall = self.data[:firewalls].find {
            |hash| hash['id'] == firewall_id
          }
            self.data[:firewalls].delete(firewall)
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 202
          response.body = 'The requested firewall has been deleted.'
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog