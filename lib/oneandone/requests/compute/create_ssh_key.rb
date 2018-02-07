module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Creates a new ssh key
        # URL: [https://cloudpanel-api.1and1.com/documentation/v1/en/api/documentation.html#ssh_keys_post]
        ##
        def create_ssh_key(name: nil, description: nil,
          public_key: nil)

          # Build POST body
          new_ssh_key = {
            'name' => name,
            'description' => description,
            'public_key' => public_key
          }

          # Clean out null values from POST body
          body = clean_hash(new_ssh_key)

          # Stringify the POST body
          string_body = Fog::JSON.encode(body)

          # Request
          params = {
            'method' => :post,
            'endpoint' => '/ssh_keys',
            'body' => string_body
          }

          request(params)

        end

      end # Real

      
      class Mock

        def create_ssh_key(name: nil, description: nil,
          public_key: nil)
          
          # Create mock ssh key hash
          mock_ssh_key = {
            "id" => Fog::UUID.uuid,
            "name" => name,
            "description" => description,
            "state" => "ACTIVE",
            "servers" => [],
            "md5" => "5df9f63916ebf8528697b629022993e8",
            "creation_date" => "2018-01-06T08:33:25+00:00",
            "public_key" => public_key
          }

          # Save mock ssh key to list
          self.data[:ssh_keys] << mock_ssh_key

          # Return mock response to user
          response = Excon::Response.new
          response.status = 202
          response.body = mock_ssh_key
            
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog