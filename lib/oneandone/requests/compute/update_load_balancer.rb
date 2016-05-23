module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Modify a load balancer
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#load_balancers__load_balancer_id__put]
        ##
        def update_load_balancer(load_balancer_id: nil, name: nil,
          description: nil, health_check_test: nil, health_check_interval: nil,
          persistence: nil, persistence_time: nil, method: nil,
          health_check_path: nil, health_check_parse: nil)
          
          # Build PUT body
          new_load_balancer = {
            'name' => name,
            'description' => description,
            'health_check_test' => health_check_test,
            'health_check_interval' => health_check_interval,
            'persistence' => persistence,
            'persistence_time' => persistence_time,
            'method' => method,
            'health_check_path' => health_check_path,
            'health_check_parse' => health_check_parse
          }

          # Clean out null keys in PUT body
          body = clean_hash(new_load_balancer)

          # Stringify the POST body
          string_body = Fog::JSON.encode(body)

          # Request
          params = {
            'method' => :put,
            'endpoint' => "/load_balancers/#{load_balancer_id}",
            'body' => string_body
          }

          request(params)

        end

      end # Real

      
      class Mock

        def update_load_balancer(load_balancer_id: nil, name: nil,
          description: nil, health_check_test: nil, health_check_interval: nil,
          persistence: nil, persistence_time: nil, method: nil,
          health_check_path: nil, health_check_parse: nil)
          
          # Search for load balancer to update
          if load_balancer = self.data[:load_balancers].find {
            |hash| hash['id'] == load_balancer_id
          }
            # Create parameter hash 
            params = {
              'name' => name,
              'description' => description,
              'health_check_test' => health_check_test,
              'health_check_interval' => health_check_interval,
              'persistence' => persistence,
              'persistence_time' => persistence_time,
              'method' => method,
              'health_check_path' => health_check_path,
              'health_check_parse' => health_check_parse
            }
            
            # Update the load balancer we found with new values
            params.each do |key, value|
              if value
                load_balancer[key] = value
              end
            end
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 202
          response.body = load_balancer
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog