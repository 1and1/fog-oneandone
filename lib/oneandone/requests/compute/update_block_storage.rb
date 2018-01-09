module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Modify a blocked storage
        # URL: [https://cloudpanel-api.1and1.com/documentation/v1/en/api/documentation.html#block_storages__block_storage_id__put]
        ##
        def update_blocked_storage(blocked_storage_id: nil, name: nil,
          description: nil, size: nil)

          # Build PUT body
          new_blocked_storage = {
            'name' => name,
            'description' => description,
            'size' => size
          }

          # Clean out null values from PUT body
          body = clean_hash(new_blocked_storage)

          # Stringify the PUT body
          string_body = Fog::JSON.encode(body)

          # Request
          params = {
            'method' => :put,
            'endpoint' => "/blocked_storages/#{blocked_storage_id}",
            'body' => string_body
          }

          request(params)

        end

      end # Real

      
      class Mock

        def update_blocked_storage(blocked_storage_id: nil, name: nil,
          description: nil, size: nil)
          
          # Search for blocked storage to update
          if blocked_storage = self.data[:blocked_storages].find {
            |hash| hash['id'] == blocked_storage_id
          }
            # Create parameter hash 
            params = {
              'name' => name,
              'description' => description,
              'size' => size
            }
            
            # Update the blocked storage we found with new values
            params.each do |key, value|
              if value
                blocked_storage[key] = value
              end
            end
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 202
          response.body = blocked_storage
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog