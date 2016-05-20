module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Removes an IP from a firewall policy
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#firewall_policies__firewall_id__server_ips__server_ip__delete]
        ##
        def remove_firewall_ip(firewall_id: nil, ip_id: nil)
          
          params = {
            'method' => :delete,
            'endpoint' => "/firewall_policies/#{firewall_id}/server_ips/#{ip_id}"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def remove_firewall_ip(firewall_id: nil, ip_id: nil)
          
          # Search for firewall
          if firewall = self.data[:firewalls].find {
            |hash| hash['id'] == firewall_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Search for server IP to destroy
          if ip = firewall['server_ips'].find {
            |index| index == ip_id
          }
            firewall['server_ips'].delete(ip)
          else
            raise Fog::Errors::NotFound.new('The requested server IP could
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