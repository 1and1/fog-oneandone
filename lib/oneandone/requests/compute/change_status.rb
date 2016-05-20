module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Change a server's status
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#servers__server_id__status_action_put]
        ##
        def change_status(server_id: nil, action: nil, method: nil)
          
          # Build PUT body
          status_specs = {
            'action' => action,
            'method' => method
          }

          # Stringify the PUT body
          string_body = Fog::JSON.encode(status_specs)

          # Request
          params = {
            'method' => :put,
            'endpoint' => "/servers/#{server_id}/status/action",
            'body' => string_body
          }

          request(params)

        end

      end # Real

      
      class Mock

        def change_status(server_id: nil, action: nil, method: nil)
          
          # Search for server
          if server = self.data[:servers].find {
            |hash| hash['id'] == server_id
          }
            if action == 'POWER_ON'
              server['status']['state'] = 'POWERED_ON'
            elsif action == 'POWER_OFF'
              server['status']['state'] = 'POWERED_OFF'
            elsif action == 'REBOOT'
              sleep 3
              server['status']['state'] = 'POWERED_ON'
            end
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