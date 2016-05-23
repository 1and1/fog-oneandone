module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Returns information about an image
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#images__image_id__get]
        ##
        def get_image(image_id)
          
          params = {
            'method' => :get,
            'endpoint' => "/images/#{image_id}"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def get_image(image_id)
          
          # Search for image to return
          if image = self.data[:images].find {
            |hash| hash['id'] == image_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 200
          response.body = image
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog