module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Install an image onto a server
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#servers__server_id__image_put]
        ##
        def install_server_image(server_id: nil, image_id: nil, password: nil,
          firewall_id: nil)
          
          # Build PUT body
          image_specs = {
            'id' => image_id,
            'password' => password,
            'firewall_policy' => {
              'id' => firewall_id
            }
          }

          # Clean out null keys in PUT body
          body = clean_hash(image_specs)

          # Stringify the PUT body
          string_body = Fog::JSON.encode(body)

          # Request
          params = {
            'method' => :put,
            'endpoint' => "/servers/#{server_id}/image",
            'body' => string_body
          }

          request(params)

        end

      end # Real

      
      class Mock

        def install_server_image(server_id: nil, image_id: nil, password: nil,
          firewall_id: nil)
          
          # Search for server
          if server = self.data[:servers].find {
            |hash| hash['id'] == server_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Update image info
          server['image']['id'] = image_id

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