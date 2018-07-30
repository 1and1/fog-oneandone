module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Add new ports to a monitoring policy
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#monitoring_policies__monitoring_policy_id__ports_post]
        ##
        def add_ports(monitoring_policy_id: nil, ports: nil)

          # Build POST body
          new_ports = {
            'ports' => ports
          }

          # Stringify the POST body
          string_body = Fog::JSON.encode(new_ports)

          # Request
          params = {
            'method' => :post,
            'endpoint' => "/monitoring_policies/#{monitoring_policy_id}/ports",
            'body' => string_body
          }

          request(params)

        end

      end # Real

      
      class Mock

        def add_ports(monitoring_policy_id: nil, ports: nil)
          
          # Search for MP to return
          if monitoring_policy = self.data[:monitoring_policies].find {
            |hash| hash['id'] == monitoring_policy_id
          }
            # Add ports
            ports.each do |port|
              port['id'] = Fog::UUID.uuid
              monitoring_policy['ports'] << port
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