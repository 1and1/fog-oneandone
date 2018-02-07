module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Modify a ssh key
        # URL: [https://cloudpanel-api.1and1.com/documentation/v1/en/api/documentation.html#ssh_keys__ssh_key_id__put]
        ##
        def update_ssh_key(ssh_key_id: nil, name: nil,
          description: nil)

          # Build PUT body
          new_ssh_key = {
            'name' => name,
            'description' => description
          }

          # Clean out null values from PUT body
          body = clean_hash(new_ssh_key)

          # Stringify the PUT body
          string_body = Fog::JSON.encode(body)

          # Request
          params = {
            'method' => :put,
            'endpoint' => "/ssh_keys/#{ssh_key_id}",
            'body' => string_body
          }

          request(params)

        end

      end # Real

      
      class Mock

        def update_ssh_key(ssh_key_id: nil, name: nil,
          description: nil)
          
          # Search for ssh key to update
          if ssh_key = self.data[:ssh_keys].find {
            |hash| hash['id'] == ssh_key_id
          }
            # Create parameter hash 
            params = {
              'name' => name,
              'description' => description
            }
            
            # Update the ssh key we found with new values
            params.each do |key, value|
              if value
                ssh_key[key] = value
              end
            end
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 202
          response.body = ssh_key
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog