module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Creates a new firewall policy
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#firewall_policies_post]
        ##
        def create_firewall(name: nil, description: nil, rules: nil)

          # Build POST body
          new_firewall = {
            'name' => name,
            'description' => description,
            'rules' => rules
          }

          # Clean out null values from POST body
          body = clean_hash(new_firewall)

          # Stringify the POST body
          string_body = Fog::JSON.encode(body)

          # Request
          params = {
            'method' => :post,
            'endpoint' => '/firewall_policies',
            'body' => string_body
          }

          request(params)

        end

      end # Real

      
      class Mock

        def create_firewall(name: nil, description: nil, rules: nil)
          
          # Add UUID to rules being passed in
          rules.each do |rule|
            rule['id'] = Fog::UUID.uuid
          end

          # Create mock firewall hash
          mock_firewall = {
            "id" => Fog::UUID.uuid,
            "name" => name,
            "description" => description,
            "state" => "ACTIVE",
            "creation_date" => "2015-04-29T10:43:11+00:00",
            "default" => 0,
            "rules" => rules,
            "server_ips" => [],
            "cloudpanel_id" => "FW99AA4_7"
          }

          # Save mock firewall to list
          self.data[:firewalls] << mock_firewall

          # Return mock response to user
          response = Excon::Response.new
          response.status = 202
          response.body = mock_firewall
            
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog