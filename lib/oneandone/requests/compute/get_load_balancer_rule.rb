module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Returns information about a load balancer's rule
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#load_balancers__load_balancer_id__rules__rule_id__get]
        ##
        def get_load_balancer_rule(load_balancer_id: nil, rule_id: nil)
          
          params = {
            'method' => :get,
            'endpoint' => "/load_balancers/#{load_balancer_id}/rules/#{rule_id}"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def get_load_balancer_rule(load_balancer_id: nil, rule_id: nil)
          
          # Search for load balancer
          if load_balancer = self.data[:load_balancers].find {
            |hash| hash['id'] == load_balancer_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Search for rule to return
          if rule = load_balancer['rules'].find {
            |index| index['id'] == rule_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested rule could
            not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 200
          response.body = rule
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog