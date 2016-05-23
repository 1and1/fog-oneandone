module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Add rules to a load balancer
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#load_balancers__load_balancer_id__rules_post]
        ##
        def add_load_balancer_rules(load_balancer_id: nil, rules: nil)
          
          # Build POST body
          new_rules = {
            'rules' => rules
          }

          # Clean out null keys in POST body
          body = clean_hash(new_rules)

          # Stringify the POST body
          string_body = Fog::JSON.encode(body)

          # Request
          params = {
            'method' => :post,
            'endpoint' => "/load_balancers/#{load_balancer_id}/rules",
            'body' => string_body
          }

          request(params)

        end

      end # Real

      
      class Mock

        def add_load_balancer_rules(load_balancer_id: nil, rules: nil)
          
          # Search for load balancer to return
          if load_balancer = self.data[:load_balancers].find {
            |hash| hash['id'] == load_balancer_id
          }
            # Add rules
            rules.each do |rule|
              rule['id'] = Fog::UUID.uuid
              load_balancer['rules'] << rule
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