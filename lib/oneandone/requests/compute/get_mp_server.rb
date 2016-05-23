module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Returns information about a monitoring policy's server
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#monitoring_policies__monitoring_policy_id__servers__server_id__get]
        ##
        def get_mp_server(monitoring_policy_id: nil, server_id: nil)
          
          params = {
            'method' => :get,
            'endpoint' => "/monitoring_policies/#{monitoring_policy_id}/servers/#{server_id}"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def get_mp_server(monitoring_policy_id: nil, server_id: nil)
          
          # Search for MP
          if monitoring_policy = self.data[:monitoring_policies].find {
            |hash| hash['id'] == monitoring_policy_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Search for server to return
          if server = monitoring_policy['servers'].find {
            |index| index == server_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested server could
            not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 200
          response.body = server
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog