module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Returns information about a monitoring policy's process
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#monitoring_policies__monitoring_policy_id__processes__process_id__get]
        ##
        def get_process(monitoring_policy_id: nil, process_id: nil)
          
          params = {
            'method' => :get,
            'endpoint' => "/monitoring_policies/#{monitoring_policy_id}/processes/#{process_id}"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def get_process(monitoring_policy_id: nil, process_id: nil)
          
          # Search for MP
          if monitoring_policy = self.data[:monitoring_policies].find {
            |hash| hash['id'] == monitoring_policy_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Search for process to return
          if process = monitoring_policy['processes'].find {
            |index| index['id'] == process_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested port could
            not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 200
          response.body = process
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog