module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Returns a list of fixed server options
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#servers_fixed_instance_sizes_get]
        ##
        def list_fixed_servers
          
          params = {
            'method' => :get,
            'endpoint' => '/servers/fixed_instance_sizes'
          }

          request(params)

        end

      end # Real

      
      class Mock

        def list_fixed_servers
          
          response = Excon::Response.new
          response.status = 200
          response.body = self.data[:fixed_servers]
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog