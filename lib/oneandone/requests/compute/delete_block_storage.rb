module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Returns information about a blocked storage
        # URL: https://cloudpanel-api.1and1.com/documentation/v1/en/api/documentation.html#block_storages__block_storage_id__delete
        ##
        def delete_blocked_storage(blocked_storage_id)
          
          params = {
            'method' => :delete,
            'endpoint' => "/blocked_storages/#{blocked_storage_id}"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def delete_blocked_storage(blocked_storage_id)
          
          # Search for blocked storage to delete
          if blocked_storage = self.data[:blocked_storages].find {
            |hash| hash['id'] == blocked_storage_id
          }
            self.data[:blocked_storages].delete(blocked_storage)
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 202
          response.body = 'The requested blocked storage has been deleted.'
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog