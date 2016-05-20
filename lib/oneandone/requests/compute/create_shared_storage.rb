module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Creates a new shared storage
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#shared_storages_post]
        ##
        def create_shared_storage(name: nil, description: nil,
          size: nil, datacenter_id: nil)

          # Build POST body
          new_shared_storage = {
            'name' => name,
            'description' => description,
            'size' => size,
            'datacenter_id' => datacenter_id
          }

          # Clean out null values from POST body
          body = clean_hash(new_shared_storage)

          # Stringify the POST body
          string_body = Fog::JSON.encode(body)

          # Request
          params = {
            'method' => :post,
            'endpoint' => '/shared_storages',
            'body' => string_body
          }

          request(params)

        end

      end # Real

      
      class Mock

        def create_shared_storage(name: nil, description: nil,
          size: nil, datacenter_id: nil)
          
          # Create mock shared storage hash
          mock_shared_storage = {
            "id" => Fog::UUID.uuid,
            "size" => size,
            "state" => "ACTIVE",
            "description" => description,
            "datacenter" => {
              "id" => datacenter_id,
              "location" => "USA",
              "country_code" => "US"
            },
            "cloudpanel_id" => "vid35780",
            "size_used" => "0.00",
            "cifs_path" => "\\vid50995.nas1.lan\vid50995",
            "nfs_path" => "vid50995.nas1.lan/:vid50995",
            "name" => name,
            "creation_date" => "2015-05-06T08:33:25+00:00",
            "servers" => []
          }

          # Save mock shared storage to list
          self.data[:shared_storages] << mock_shared_storage

          # Return mock response to user
          response = Excon::Response.new
          response.status = 202
          response.body = mock_shared_storage
            
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog