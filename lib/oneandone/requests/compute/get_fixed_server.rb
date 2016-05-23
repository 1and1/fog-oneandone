module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Returns information about a fixed server option
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#servers_fixed_instance_sizes__fixed_instance_size_id__get]
        ##
        def get_fixed_server(fixed_instance_id)
          
          params = {
            'method' => :get,
            'endpoint' => "/servers/fixed_instance_sizes/#{fixed_instance_id}"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def get_fixed_server(fixed_instance_id)
          
          # Search for fixed server to return
          if fixed_server = self.data[:fixed_servers].find {
            |hash| hash['id'] == fixed_instance_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 202
          response.body = fixed_server
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog