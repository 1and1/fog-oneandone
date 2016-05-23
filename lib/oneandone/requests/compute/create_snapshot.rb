module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Create a server snapshot
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#servers__server_id__snapshots_post]
        ##
        def create_snapshot(server_id)
          
          params = {
            'method' => :post,
            'endpoint' => "/servers/#{server_id}/snapshots"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def create_snapshot(server_id)
          
          # Search for server
          if server = self.data[:servers].find {
            |hash| hash['id'] == server_id
          }
            server['snapshot']['id'] = Fog::UUID.uuid
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