module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Creates a new block storage
        # URL: [https://cloudpanel-api.1and1.com/documentation/v1/en/api/documentation.html#block_storages_post]
        ##
        def create_block_storage(name: nil, description: nil,
          size: nil, datacenter_id: nil, server_id: nil)

          # Build POST body
          new_block_storage = {
            'name' => name,
            'description' => description,
            'size' => size,
            'datacenter_id' => datacenter_id,
            'server' => server_id
          }

          # Clean out null values from POST body
          body = clean_hash(new_block_storage)

          # Stringify the POST body
          string_body = Fog::JSON.encode(body)

          # Request
          params = {
            'method' => :post,
            'endpoint' => '/block_storages',
            'body' => string_body
          }

          request(params)

        end

      end # Real

      
      class Mock

        def create_block_storage(name: nil, description: nil,
          size: nil, datacenter_id: nil, server_id: nil)
          
          # Create mock block storage hash
          mock_block_storage = {
            "id" => Fog::UUID.uuid,
            "size" => size,
            "state" => "ACTIVE",
            "description" => description,
            "datacenter" => {
              "id" => datacenter_id,
              "location" => "USA",
              "country_code" => "US"
            },
            "name" => name,
            "creation_date" => "2018-01-06T08:33:25+00:00",
            "server" => server_id
          }

          # Save mock block storage to list
          self.data[:block_storages] << mock_block_storage

          # Return mock response to user
          response = Excon::Response.new
          response.status = 202
          response.body = mock_block_storage
            
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog