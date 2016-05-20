module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Returns information about a monitoring policy's port
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#monitoring_policies__monitoring_policy_id__ports__port_id__get]
        ##
        def get_port(monitoring_policy_id: nil, port_id: nil)
          
          params = {
            'method' => :get,
            'endpoint' => "/monitoring_policies/#{monitoring_policy_id}/ports/#{port_id}"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def get_port(monitoring_policy_id: nil, port_id: nil)
          
          # Search for MP
          if monitoring_policy = self.data[:monitoring_policies].find {
            |hash| hash['id'] == monitoring_policy_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Search for port to return
          if port = monitoring_policy['ports'].find {
            |index| index['id'] == port_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested port could
            not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 200
          response.body = port
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog