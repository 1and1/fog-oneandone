module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Modify a monitoring policy's process
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#monitoring_policies__monitoring_policy_id__processes__process_id__put]
        ##
        def update_process(monitoring_policy_id: nil, process_id: nil,
          new_process: nil)
          
          # Build PUT body
          modified_process = {
            'processes' => new_process
          }

          # Stringify the PUT body
          string_body = Fog::JSON.encode(modified_process)

          # Request
          params = {
            'method' => :put,
            'endpoint' => "/monitoring_policies/#{monitoring_policy_id}/processes/#{process_id}",
            'body' => string_body
          }

          request(params)

        end

      end # Real

      
      class Mock

        def update_process(monitoring_policy_id: nil, process_id: nil,
          new_process: nil)
          
          # Search for MP
          if monitoring_policy = self.data[:monitoring_policies].find {
            |hash| hash['id'] == monitoring_policy_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Search for process to update
          if process = monitoring_policy['processes'].find {
            |index| index['id'] == process_id
          }

            # Update the process with new values
            new_process.each do |key, value|
              process[key] = value
            end
          else
            raise Fog::Errors::NotFound.new('The requested process could
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