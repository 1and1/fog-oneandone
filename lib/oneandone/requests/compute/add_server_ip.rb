module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Add a new IP to the server
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#servers__server_id__ips_post]
        ##
        def add_server_ip(server_id: nil, type: nil)
          
          # Build POST body
          ip_specs = {
            'type' => type
          }

          # Clean out null keys in POST body
          body = clean_hash(ip_specs)

          # Stringify the POST body
          string_body = Fog::JSON.encode(body)

          # Request
          params = {
            'method' => :post,
            'endpoint' => "/servers/#{server_id}/ips",
            'body' => string_body
          }

          request(params)

        end

      end # Real

      
      class Mock

        def add_server_ip(server_id: nil, type: nil)
          
          # Search for server to return
          if server = self.data[:servers].find {
            |hash| hash['id'] == server_id
          }
            # Add IP
            new_ip = {
              'id' => Fog::UUID.uuid,
              'type' => type,
              'firewall_policy' => {},
              'load_balancers' => []
            }

            server['ips'] << new_ip
          else
            raise Fog::Errors::NotFound.new('The requested resource could
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