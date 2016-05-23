module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Returns a list of a load balancer's rules
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#load_balancers__load_balancer_id__rules_get]
        ##
        def list_load_balancer_rules(load_balancer_id)
          
          params = {
            'method' => :get,
            'endpoint' => "/load_balancers/#{load_balancer_id}/rules"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def list_load_balancer_rules(load_balancer_id)
          
          # Search for load balancer to return
          if load_balancer = self.data[:load_balancers].find {
            |hash| hash['id'] == load_balancer_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 202
          response.body = load_balancer['rules']
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog