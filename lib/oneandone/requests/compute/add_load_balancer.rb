module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Add a load balancer to a server's IP
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#servers__server_id__ips__ip_id__load_balancers_post]
        ##
        def add_load_balancer(server_id: nil, ip_id: nil,
          load_balancer_id: nil)
          
          # Build POST body
          load_balancer_specs = {
            'load_balancer_id' => load_balancer_id
          }

          # Stringify the POST body
          string_body = Fog::JSON.encode(load_balancer_specs)

          # Request
          params = {
            'method' => :post,
            'endpoint' => "/servers/#{server_id}/ips/#{ip_id}/load_balancers",
            'body' => string_body
          }

          request(params)

        end

      end # Real

      
      class Mock

        def add_load_balancer(server_id: nil, ip_id: nil,
          load_balancer_id: nil)
          
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
            load_balancer = {
              'id' => load_balancer_id
            }

            ip['load_balancers'] << load_balancer
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