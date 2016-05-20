module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Returns information about a firewall policy's rule
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#firewall_policies__firewall_id__rules__rule_id__get]
        ##
        def get_firewall_rule(firewall_id: nil, rule_id: nil)
          
          params = {
            'method' => :get,
            'endpoint' => "/firewall_policies/#{firewall_id}/rules/#{rule_id}"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def get_firewall_rule(firewall_id: nil, rule_id: nil)
          
          # Search for firewall
          if firewall = self.data[:firewalls].find {
            |hash| hash['id'] == firewall_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Search for rule to return
          if rule = firewall['rules'].find {
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