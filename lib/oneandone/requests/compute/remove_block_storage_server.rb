module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Removes a server from a block storage
        # URL: [https://cloudpanel-api.1and1.com/documentation/v1/en/api/documentation.html#]
        ##
        def remove_block_storage_server(block_storage_id: nil)
          
          params = {
            'method' => :delete,
            'endpoint' => "/block_storages/#{block_storage_id}/server"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def remove_block_storage_server(block_storage_id: nil)
          
          # Search for block storage
          if block_storage = self.data[:block_storages].find {
            |hash| hash['id'] == block_storage_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 202
          response.body = block_storage
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog