module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Returns information about a block storage
        # URL: https://cloudpanel-api.1and1.com/documentation/v1/en/api/documentation.html#block_storages__block_storage_id__delete
        ##
        def delete_block_storage(block_storage_id)
          
          params = {
            'method' => :delete,
            'endpoint' => "/block_storages/#{block_storage_id}"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def delete_block_storage(block_storage_id)
          
          # Search for block storage to delete
          if block_storage = self.data[:block_storages].find {
            |hash| hash['id'] == block_storage_id
          }
            self.data[:block_storages].delete(block_storage)
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 202
          response.body = 'The requested block storage has been deleted.'
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog