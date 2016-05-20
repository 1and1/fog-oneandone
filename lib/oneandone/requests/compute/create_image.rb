module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Creates a new image
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#images_post]
        ##
        def create_image(server_id: nil, name: nil, description: nil,
          frequency: nil, num_images: nil)

          # Build POST body
          new_image = {
            'server_id' => server_id,
            'name' => name,
            'description' => description,
            'frequency' => frequency,
            'num_images' => num_images
          }

          # Clean out null values from POST body
          body = clean_hash(new_image)

          # Stringify the POST body
          string_body = Fog::JSON.encode(body)

          # Request
          params = {
            'method' => :post,
            'endpoint' => '/images',
            'body' => string_body
          }

          request(params)

        end

      end # Real

      
      class Mock

        def create_image(server_id: nil, name: nil, description: nil,
          frequency: nil, num_images: nil)
          
          # Create mock image hash
          mock_image = {
            "id" => Fog::UUID.uuid,
            "name" => name,
            "datacenter" => {
              "id" => "D0F6D8C8ED29D3036F94C27BBB7BAD36",
              "location" => "USA",
              "country_code" => "US"
            },
            "os_family" => "Windows",
            "os" => "WindowsDatacenter",
            "os_version" => "Windows2012R2",
            "architecture" => 64,
            "os_image_type" => "Personal",
            "type" => "MY_IMAGE",
            "min_hdd_size" => 40,
            "licenses" => [
            {
              "name" => "Windows 2012 Standard"
            }
            ],
            "cloudpanel_id" => "ap8962D_253",
            "state" => "ENABLED",
            "description" => description,
            "hdds" => [
            {
              "id" => "D0289C1FDF48628FE53335470EEC05DB",
              "size" => 40,
              "is_main" => true
            }
            ],
            "server_id" => server_id,
            "frequency" => frequency,
            "num_images" => num_images,
            "creation_date" => "2015-05-06T08:04:41+00:00"
          }

          # Save mock image to images list
          self.data[:images] << mock_image

          # Return mock response to user
          response = Excon::Response.new
          response.status = 202
          response.body = mock_image
            
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog