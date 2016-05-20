module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Returns a list of the servers attached to a shared storage
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#shared_storages__shared_storage_id__servers_get]
        ##
        def list_shared_storage_servers(shared_storage_id)
          
          params = {
            'method' => :get,
            'endpoint' => "/shared_storages/#{shared_storage_id}/servers"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def list_shared_storage_servers(shared_storage_id)
          
          # Search for shared storage to return
          if shared_storage = self.data[:shared_storages].find {
            |hash| hash['id'] == shared_storage_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 202
          response.body = shared_storage['servers']
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog