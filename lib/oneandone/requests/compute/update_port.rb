module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Modify a monitoring policy's port
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#monitoring_policies__monitoring_policy_id__ports__port_id__put]
        ##
        def update_port(monitoring_policy_id: nil, port_id: nil, new_port: nil)
          
          # Build PUT body
          modified_port = {
            'ports' => new_port
          }

          # Stringify the PUT body
          string_body = Fog::JSON.encode(modified_port)

          # Request
          params = {
            'method' => :put,
            'endpoint' => "/monitoring_policies/#{monitoring_policy_id}/ports/#{port_id}",
            'body' => string_body
          }

          request(params)

        end

      end # Real

      
      class Mock

        def update_port(monitoring_policy_id: nil, port_id: nil, new_port: nil)
          
          # Search for MP
          if monitoring_policy = self.data[:monitoring_policies].find {
            |hash| hash['id'] == monitoring_policy_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Search for port to update
          if port = monitoring_policy['ports'].find {
            |index| index['id'] == port_id
          }

            # Update the port with new values
            new_port.each do |key, value|
              port[key] = value
            end
          else
            raise Fog::Errors::NotFound.new('The requested port could
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