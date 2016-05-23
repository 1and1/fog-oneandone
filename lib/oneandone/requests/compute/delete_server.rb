module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Deletes a server
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#servers__server_id__delete]
        ##
        def delete_server(server_id)
          
          params = {
            'method' => :delete,
            'endpoint' => "/servers/#{server_id}"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def delete_server(server_id)
          
          # Search for server to delete
          if server = self.data[:servers].find {
            |hash| hash['id'] == server_id
          }
            self.data[:servers].delete(server)
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 202
          response.body = 'The requested server has been deleted.'
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog