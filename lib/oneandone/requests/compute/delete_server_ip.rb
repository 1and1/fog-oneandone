module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Delete a server's IP
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#servers__server_id__ips__ip_id__delete]
        ##
        def delete_server_ip(server_id: nil, ip_id: nil)
          
          params = {
            'method' => :delete,
            'endpoint' => "/servers/#{server_id}/ips/#{ip_id}"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def delete_server_ip(server_id: nil, ip_id: nil)
          
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
            server['ips'].delete(ip)
          else
            raise Fog::Errors::NotFound.new('The requested server IP could
            not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 200
          response.body = server
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog