module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Resize a server's HDD
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#servers__server_id__hardware_hdds__hdd_id__put]
        ##
        def update_hdd(server_id: nil, hdd_id: nil, size: nil)

          # Build PUT body
          hdd_specs = {
            'size' => size
          }

          # Stringify the PUT body
          string_body = Fog::JSON.encode(hdd_specs)

          # Request
          params = {
            'method' => :put,
            'endpoint' => "/servers/#{server_id}/hardware/hdds/#{hdd_id}",
            'body' => string_body
          }

          request(params)

        end

      end # Real

      
      class Mock

        def update_hdd(server_id: nil, hdd_id: nil, size: nil)
          
          # Search for server to update
          if server = self.data[:servers].find {
            |hash| hash['id'] == server_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Search for server's hdd to update
          if hdd = server['hardware']['hdds'].find {
            |hash| hash['id'] == hdd_id
          }
            # Update the server hdd with new values
            hdd['size'] = size
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