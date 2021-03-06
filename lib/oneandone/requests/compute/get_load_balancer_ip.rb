module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Returns information about an IP assigned to a load balancer
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#load_balancers__load_balancer_id__server_ips__server_ip__get]
        ##
        def get_load_balancer_ip(load_balancer_id: nil, ip_id: nil)
          
          params = {
            'method' => :get,
            'endpoint' => "/load_balancers/#{load_balancer_id}/server_ips/#{ip_id}"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def get_load_balancer_ip(load_balancer_id: nil, ip_id: nil)
          
          # Search for load balancer
          if load_balancer = self.data[:load_balancers].find {
            |hash| hash['id'] == load_balancer_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Search for server IP to return
          if ip = load_balancer['server_ips'].find {
            |string| string == ip_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested server IP could
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