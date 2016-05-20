module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Create a new load balancer
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#load_balancers_post]
        ##
        def create_load_balancer(name: nil, description: nil,
          health_check_test: nil, health_check_interval: nil, persistence: nil,
          persistence_time: nil, method: nil, rules: nil,
          health_check_path: nil, health_check_parse: nil, datacenter_id: nil)

          # Build POST body
          new_load_balancer = {
            'name' => name,
            'description' => description,
            'health_check_test' => health_check_test,
            'health_check_interval' => health_check_interval,
            'persistence' => persistence,
            'persistence_time' => persistence_time,
            'method' => method,
            'rules' => rules,
            'health_check_path' => health_check_path,
            'health_check_parse' => health_check_parse,
            'datacenter_id' => datacenter_id
          }

          # Clean out null keys in POST body
          body = clean_hash(new_load_balancer)

          # Stringify the POST body
          string_body = Fog::JSON.encode(body)

          # Request
          params = {
            'method' => :post,
            'endpoint' => '/load_balancers',
            'body' => string_body
          }

          request(params)

        end

      end # Real

      
      class Mock

        def create_load_balancer(name: nil, description: nil,
          health_check_test: nil, health_check_interval: nil, persistence: nil,
          persistence_time: nil, method: nil, rules: nil,
          health_check_path: nil, health_check_parse: nil, datacenter_id: nil)
          
          # Add UUID to rules being passed in
          rules.each do |rule|
            rule['id'] = Fog::UUID.uuid
          end

          # Create mock load balancer hash
          mock_load_balancer = {
            "id" => Fog::UUID.uuid,
            "name" => name,
            "state" => "ACTIVE",
            "creation_date" => "2015-05-04T07:26:24+00:00",
            "description" => description,
            "ip" => nil,
            "health_check_test" => health_check_test,
            "health_check_interval" => health_check_interval,
            "health_check_path" => health_check_path,
            "health_check_path_parser" => health_check_parse,
            "persistence" => persistence,
            "persistence_time" => persistence_time,
            "method" => method,
            "datacenter" => {
              "id" => datacenter_id,
              "location" => "USA",
              "country_code" => "US"
            },
            "rules" => rules,
            "server_ips" => [],
            "cloudpanel_id" => "LB99AA4_1"
          }

          # Save mock load balancer to list
          self.data[:load_balancers] << mock_load_balancer

          # Return mock response to user
          response = Excon::Response.new
          response.status = 202
          response.body = mock_load_balancer
            
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog