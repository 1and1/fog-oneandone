module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Remove a load balancer from a server's IP
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#servers__server_id__ips__ip_id__load_balancers__load_balancer_id__delete]
        ##
        def remove_load_balancer(server_id: nil, ip_id: nil,
          load_balancer_id: nil)
          
          params = {
            'method' => :delete,
            'endpoint' => "/servers/#{server_id}/ips/#{ip_id}/load_balancers/#{load_balancer_id}"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def remove_load_balancer(server_id: nil, ip_id: nil,
          load_balancer_id: nil)
          
          # Search for server
          if server = self.data[:servers].find {
            |hash| hash['id'] == server_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Search for IP
          if ip = server['ips'].find {
            |index| index['id'] == ip_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested server IP could
            not be found.')
          end

          # Search for load balancer to destroy
          if load_balancer = ip['load_balancers'].find {
            |index| index['id'] == load_balancer_id
          }
            ip['load_balancers'].delete(load_balancer)
          else
            raise Fog::Errors::NotFound.new('The requested load balancer could
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