module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Add new processes to a monitoring policy
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#monitoring_policies__monitoring_policy_id__processes_post]
        ##
        def add_processes(monitoring_policy_id: nil, processes: nil)

          # Build POST body
          new_processes = {
            'processes' => processes
          }

          # Stringify the POST body
          string_body = Fog::JSON.encode(new_processes)

          # Request
          params = {
            'method' => :post,
            'endpoint' => "/monitoring_policies/#{monitoring_policy_id}/processes",
            'body' => string_body
          }

          request(params)

        end

      end # Real

      
      class Mock

        def add_processes(monitoring_policy_id: nil, processes: nil)
          
          # Search for MP to return
          if monitoring_policy = self.data[:monitoring_policies].find {
            |hash| hash['id'] == monitoring_policy_id
          }
            # Add processes
            processes.each do |process|
              process['id'] = Fog::UUID.uuid
              monitoring_policy['processes'] << process
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