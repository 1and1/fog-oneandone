module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Modify an image
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#images__image_id__put]
        ##
        def update_image(image_id: nil, name: nil, description: nil,
          frequency: nil)

          # Build PUT body
          new_image = {
            'name' => name,
            'description' => description,
            'frequency' => frequency
          }

          # Clean out null values from PUT body
          body = clean_hash(new_image)

          # Stringify the PUT body
          string_body = Fog::JSON.encode(body)

          # Request
          params = {
            'method' => :put,
            'endpoint' => "/images/#{image_id}",
            'body' => string_body
          }

          request(params)

        end

      end # Real

      
      class Mock

        def update_image(image_id: nil, name: nil, description: nil,
          frequency: nil)
          
          # Search for image to update
          if image = self.data[:images].find {
            |hash| hash['id'] == image_id
          }
            # Create parameter hash 
            params = {
              'name' => name,
              'description' => description,
              'frequency' => frequency
            }
            
            # Update the image we found with new values
            params.each do |key, value|
              if value
                image[key] = value
              end
            end
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 202
          response.body = image
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog