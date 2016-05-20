module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Add servers to a monitoring policy
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#monitoring_policies__monitoring_policy_id__servers_post]
        ##
        def add_mp_servers(monitoring_policy_id: nil, servers: nil)
          
          # Build POST body
          new_servers = {
            'servers' => servers
          }

          # Stringify the POST body
          string_body = Fog::JSON.encode(new_servers)

          # Request
          params = {
            'method' => :post,
            'endpoint' => "/monitoring_policies/#{monitoring_policy_id}/servers",
            'body' => string_body
          }

          request(params)

        end

      end # Real

      
      class Mock

        def add_mp_servers(monitoring_policy_id: nil, servers: nil)
          
          # Search for MP to return
          if monitoring_policy = self.data[:monitoring_policies].find {
            |hash| hash['id'] == monitoring_policy_id
          }
            # Add servers
            servers.each do |server|
              monitoring_policy['servers'] << server
            end
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 202
          response.body = monitoring_policy
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog