module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Remove a monitoring policy's port
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#monitoring_policies__monitoring_policy_id__ports__port_id__delete]
        ##
        def delete_port(monitoring_policy_id: nil, port_id: nil)
          
          params = {
            'method' => :delete,
            'endpoint' => "/monitoring_policies/#{monitoring_policy_id}/ports/#{port_id}"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def delete_port(monitoring_policy_id: nil, port_id: nil)
          
          # Search for MP
          if monitoring_policy = self.data[:monitoring_policies].find {
            |hash| hash['id'] == monitoring_policy_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Search for port to destroy
          if port = monitoring_policy['ports'].find {
            |index| index['id'] == port_id
          }
            monitoring_policy['ports'].delete(port)
          else
            raise Fog::Errors::NotFound.new('The requested rule could
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