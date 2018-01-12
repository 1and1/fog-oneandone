module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Attach a server to a block storage
        # URL: [https://cloudpanel-api.1and1.com/documentation/v1/en/api/documentation.html#block_storages__block_storage_id__server_post]
        ##
        def add_block_storage_server(block_storage_id: nil, server_id: nil)

          # Build POST body
          add_server = {
            'server_id' => server_id
          }

          # Stringify the POST body
          string_body = Fog::JSON.encode(add_server)

          # Request
          params = {
            'method' => :post,
            'endpoint' => "/block_storages/#{block_storage_id}/server",
            'body' => string_body
          }

          request(params)

        end

      end # Real

      
      class Mock

        def add_block_storage_server(block_storage_id: nil, server_id: nil)
          
          # Search for block storage to return
          if block_storage = self.data[:block_storages].find {
            |hash| hash['id'] == block_storage_id
          }
            block_storage['server'] << {"id" => server_id}
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