module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Delete a server's HDD
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#servers__server_id__hardware_hdds__hdd_id__delete]
        ##
        def delete_hdd(server_id: nil, hdd_id: nil)

          # Request
          params = {
            'method' => :delete,
            'endpoint' => "/servers/#{server_id}/hardware/hdds/#{hdd_id}"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def delete_hdd(server_id: nil, hdd_id: nil)
          
          # Search for server
          if server = self.data[:servers].find {
            |hash| hash['id'] == server_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Search for hdd to return
          if hdd = server['hardware']['hdds'].find {
            |index| index['id'] == hdd_id
          }
            server['hardware']['hdds'].delete(hdd)
          else
            raise Fog::Errors::NotFound.new('The requested HDD could
            not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 202
          response.body = server
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog