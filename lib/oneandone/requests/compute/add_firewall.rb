module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Add a firewall policy to a server's IP
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#servers__server_id__ips__ip_id__firewall_policy_put]
        ##
        def add_firewall(server_id: nil, ip_id: nil, firewall_id: nil)
          
          # Build PUT body
          firewall_specs = {
            'id' => firewall_id
          }

          # Stringify the PUT body
          string_body = Fog::JSON.encode(firewall_specs)

          # Request
          params = {
            'method' => :put,
            'endpoint' => "/servers/#{server_id}/ips/#{ip_id}/firewall_policy",
            'body' => string_body
          }

          request(params)

        end

      end # Real

      
      class Mock

        def add_firewall(server_id: nil, ip_id: nil, firewall_id: nil)
          
          # Search for server
          if server = self.data[:servers].find {
            |hash| hash['id'] == server_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Search for IP to return
          if ip = server['ips'].find {
            |index| index['id'] == ip_id
          }
            ip['firewall_policy']['id'] = firewall_id
          else
            raise Fog::Errors::NotFound.new('The requested server IP could
            not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 202
          response.body = server
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog