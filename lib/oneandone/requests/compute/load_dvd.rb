module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Loads a DVD into the virtual DVD unit of a server
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#servers__server_id__dvd_put]
        ##
        def load_dvd(server_id: nil, dvd_id: nil)
          
          # Build PUT body
          dvd_specs = {
            'id' => dvd_id
          }

          # Stringify the PUT body
          string_body = Fog::JSON.encode(dvd_specs)

          # Request
          params = {
            'method' => :put,
            'endpoint' => "/servers/#{server_id}/dvd",
            'body' => string_body
          }

          request(params)

        end

      end # Real

      
      class Mock

        def load_dvd(server_id: nil, dvd_id: nil)
          
          # Search for server
          if server = self.data[:servers].find {
            |hash| hash['id'] == server_id
          }
            dvd = {
              'id' => dvd_id
            }

            server['dvd'] = dvd
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 200
          response.body = server
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog