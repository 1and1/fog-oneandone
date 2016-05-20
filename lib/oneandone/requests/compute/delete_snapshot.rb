module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Removes a snapshot
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#servers__server_id__snapshots__snapshot_id__delete]
        ##
        def delete_snapshot(server_id: nil, snapshot_id: nil)
          
          params = {
            'method' => :delete,
            'endpoint' => "/servers/#{server_id}/snapshots/#{snapshot_id}"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def delete_snapshot(server_id: nil, snapshot_id: nil)
          
          # Search for server
          if server = self.data[:servers].find {
            |hash| hash['id'] == server_id
          }
            server['snapshot'] = {}
          else
            raise Fog::Errors::NotFound.new('The requested resource could
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