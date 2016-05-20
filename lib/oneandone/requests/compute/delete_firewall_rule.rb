module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Delete a firewall policy's rule
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#firewall_policies__firewall_id__rules__rule_id__delete]
        ##
        def delete_firewall_rule(firewall_id: nil, rule_id: nil)
          
          params = {
            'method' => :delete,
            'endpoint' => "/firewall_policies/#{firewall_id}/rules/#{rule_id}"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def delete_firewall_rule(firewall_id: nil, rule_id: nil)
          
          # Search for firewall
          if firewall = self.data[:firewalls].find {
            |hash| hash['id'] == firewall_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Search for rule to destroy
          if rule = firewall['rules'].find {
            |index| index['id'] == rule_id
          }
            firewall['rules'].delete(rule)
          else
            raise Fog::Errors::NotFound.new('The requested rule could
            not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 202
          response.body = firewall
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog