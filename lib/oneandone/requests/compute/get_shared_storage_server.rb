module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Returns information about a server attached to a shared storage
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#shared_storages__shared_storage_id__servers__server_id__get]
        ##
        def get_shared_storage_server(shared_storage_id: nil, server_id: nil)
          
          params = {
            'method' => :get,
            'endpoint' => "/shared_storages/#{shared_storage_id}/servers/#{server_id}"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def get_shared_storage_server(shared_storage_id: nil, server_id: nil)
          
          # Search for shared storage
          if shared_storage = self.data[:shared_storages].find {
            |hash| hash['id'] == shared_storage_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Search for server to return
          if server = shared_storage['servers'].find {
            |index| index['id'] == server_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested server could
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