module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Returns information about a monitoring policy
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#monitoring_policies__monitoring_policy_id__get]
        ##
        def get_monitoring_policy(monitoring_policy_id)
          
          params = {
            'method' => :get,
            'endpoint' => "/monitoring_policies/#{monitoring_policy_id}"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def get_monitoring_policy(monitoring_policy_id)
          
          # Search for MP to return
          if monitoring_policy = self.data[:monitoring_policies].find {
            |hash| hash['id'] == monitoring_policy_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 200
          response.body = monitoring_policy
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog