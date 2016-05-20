module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Creates a new monitoring policy
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#monitoring_policies_post]
        ##
        def create_monitoring_policy(name: nil, description: nil, email: nil,
          agent: nil, thresholds: nil, ports: nil, processes: nil)

          # Build POST body
          new_monitoring_policy = {
            'name' => name,
            'description' => description,
            'email' => email,
            'agent' => agent,
            'thresholds' => thresholds,
            'ports' => ports,
            'processes' => processes
          }

          # Clean out null keys in POST body
          body = clean_hash(new_monitoring_policy)

          # Stringify the POST body
          string_body = Fog::JSON.encode(body)

          # Request
          params = {
            'method' => :post,
            'endpoint' => '/monitoring_policies',
            'body' => string_body
          }

          request(params)

        end

      end # Real

      
      class Mock

        def create_monitoring_policy(name: nil, description: nil, email: nil,
          agent: nil, thresholds: nil, ports: nil, processes: nil)
          
          # Add UUID to ports being passed in
          ports.each do |port|
            port['id'] = Fog::UUID.uuid
          end

          # Add UUID to processes being passed in
          processes.each do |process|
            process['id'] = Fog::UUID.uuid
          end

          # Create mock monitoring policy hash
          mock_monitoring_policy = {
            "id" => Fog::UUID.uuid,
            "name" => name,
            "description" => description,
            "default" => 0,
            "state" => "ACTIVE",
            "creation_date" => "2015-05-07T07:34:41+00:00",
            "email" => email,
            "agent" => agent,
            "servers" => [],
            "thresholds" => thresholds,
            "ports" => ports,
            "processes" => processes,
            "cloudpanel_id" => "mo8962D_3"
          }

          # Save mock monitoring policy to list
          self.data[:monitoring_policies] << mock_monitoring_policy

          # Return mock response to user
          response = Excon::Response.new
          response.status = 202
          response.body = mock_monitoring_policy
            
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog