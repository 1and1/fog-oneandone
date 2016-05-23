module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Update a server's specs
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#servers__server_id__put]
        ##
        def update_server(server_id: nil, name: nil, description: nil)
          
          # Build PUT body
          server_specs = {
            'name' => name,
            'description' => description
          }

          # Clean out null keys in PUT body
          body = clean_hash(server_specs)

          # Stringify the PUT body
          string_body = Fog::JSON.encode(body)

          # Request
          params = {
            'method' => :put,
            'endpoint' => "/servers/#{server_id}",
            'body' => string_body
          }

          request(params)

        end

      end # Real

      
      class Mock

        def update_server(server_id: nil, name: nil, description: nil)
          
          # Search for server to update
          if server = self.data[:servers].find {
            |hash| hash['id'] == server_id
          }
            # Create parameter hash 
            params = {
              'name' => name,
              'description' => description
            }
            
            # Update the server we found with new values
            params.each do |key, value|
              if value
                server[key] = value
              end
            end
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 202
          response.body = server
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog