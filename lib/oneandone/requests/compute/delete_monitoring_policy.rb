module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Deletes a monitoring policy
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#monitoring_policies__monitoring_policy_id__delete]
        ##
        def delete_monitoring_policy(monitoring_policy_id)
          
          params = {
            'method' => :delete,
            'endpoint' => "/monitoring_policies/#{monitoring_policy_id}"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def delete_monitoring_policy(monitoring_policy_id)
          
          # Search for MP to delete
          if monitoring_policy = self.data[:monitoring_policies].find {
            |hash| hash['id'] == monitoring_policy_id
          }
            self.data[:monitoring_policies].delete(monitoring_policy)
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 202
          response.body = 'The requested monitoring policy has been deleted.'
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog