module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Delete an image
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#images__image_id__delete]
        ##
        def delete_image(image_id)
          
          params = {
            'method' => :delete,
            'endpoint' => "/images/#{image_id}"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def delete_image(image_id)
          
          # Search for image to delete
          if image = self.data[:images].find {
            |hash| hash['id'] == image_id
          }
            self.data[:images].delete(image)
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 202
          response.body = 'The requested image has been deleted.'
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog