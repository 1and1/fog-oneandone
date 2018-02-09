module Fog
  module Compute
    class OneAndOne
      class Real
        ##
        # Returns information about a baremetal model
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#]
        ##
        def get_baremetal_model(id)
          
          params = {
            'method' => :get,
            'endpoint' => "/servers/baremetal_models/#{id}"
          }

          request(params)

        end
      end # Real
      
      class Mock
        def get_baremetal_model(id)
          
          # Search for baremetal model to return
          if baremetal_model = self.data[:baremetal_models].find {
            |hash| hash['id'] == id
          }
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 200
          response.body = baremetal_model
          response
        end
      end # Mock
    end # OneAndOne
  end # Compute
end # Fog