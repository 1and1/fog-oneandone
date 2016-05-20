module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Returns information about a shared storage
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#shared_storages__shared_storage_id__get]
        ##
        def delete_shared_storage(shared_storage_id)
          
          params = {
            'method' => :delete,
            'endpoint' => "/shared_storages/#{shared_storage_id}"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def delete_shared_storage(shared_storage_id)
          
          # Search for shared storage to delete
          if shared_storage = self.data[:shared_storages].find {
            |hash| hash['id'] == shared_storage_id
          }
            self.data[:shared_storages].delete(shared_storage)
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 202
          response.body = 'The requested shared storage has been deleted.'
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog