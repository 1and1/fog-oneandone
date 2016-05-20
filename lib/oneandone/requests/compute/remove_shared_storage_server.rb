module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Removes a server from a shared storage
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#shared_storages__shared_storage_id__servers__server_id__delete]
        ##
        def remove_shared_storage_server(shared_storage_id: nil, server_id: nil)
          
          params = {
            'method' => :delete,
            'endpoint' => "/shared_storages/#{shared_storage_id}/servers/#{server_id}"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def remove_shared_storage_server(shared_storage_id: nil, server_id: nil)
          
          # Search for shared storage
          if shared_storage = self.data[:shared_storages].find {
            |hash| hash['id'] == shared_storage_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Search for server to destroy
          if server = shared_storage['servers'].find {
            |index| index['id'] == server_id
          }
            shared_storage['servers'].delete(server)
          else
            raise Fog::Errors::NotFound.new('The requested server could
            not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 202
          response.body = shared_storage
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog