module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Returns information about a datacenter
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#datacenters__datacenter_id__get]
        ##
        def get_datacenter(datacenter_id)
          
          params = {
            'method' => :get,
            'endpoint' => "/datacenters/#{datacenter_id}"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def get_datacenter(datacenter_id)
          
          # Search for image to return
          if datacenter = self.data[:datacenters].find {
            |hash| hash['id'] == datacenter_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 200
          response.body = datacenter
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog