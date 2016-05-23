module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Returns information about an IP assigned to a firewall policy
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#firewall_policies__firewall_id__server_ips__server_ip__get]
        ##
        def get_firewall_ip(firewall_id: nil, ip_id: nil)
          
          params = {
            'method' => :get,
            'endpoint' => "/firewall_policies/#{firewall_id}/server_ips/#{ip_id}"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def get_firewall_ip(firewall_id: nil, ip_id: nil)
          
          # Search for firewall
          if firewall = self.data[:firewalls].find {
            |hash| hash['id'] == firewall_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Search for server IP to return
          if ip = firewall['server_ips'].find {
            |string| string == ip_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested server could
            not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 200
          response.body = ip
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog