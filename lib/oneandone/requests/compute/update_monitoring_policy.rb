module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Modify a monitoring policy
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#monitoring_policies__monitoring_policy_id__put]
        ##
        def update_monitoring_policy(monitoring_policy_id: nil, name: nil,
          description: nil, email: nil, thresholds: nil)

          # Build PUT body
          modified_mp = {
            'name' => name,
            'description' => description,
            'email' => email,
            'thresholds' => thresholds
          }

          # Clean out null keys in PUT body
          body = clean_hash(modified_mp)

          # Stringify the PUT body
          string_body = Fog::JSON.encode(body)

          # Request
          params = {
            'method' => :put,
            'endpoint' => "/monitoring_policies/#{monitoring_policy_id}",
            'body' => string_body
          }

          request(params)

        end

      end # Real

      
      class Mock

        def update_monitoring_policy(monitoring_policy_id: nil, name: nil,
          description: nil, email: nil, thresholds: nil)
          
          # Search for MP to update
          if monitoring_policy = self.data[:monitoring_policies].find {
            |hash| hash['id'] == monitoring_policy_id
          }
            # Create parameter hash 
            params = {
              'name' => name,
              'description' => description,
              'email' => email,
              'thresholds' => thresholds
            }
            
            # Update the MP we found with new values
            params.each do |key, value|
              if value
                monitoring_policy[key] = value
              end
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