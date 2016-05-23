module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Add new HDD's to a server
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#servers__server_id__hardware_hdds_post]
        ##
        def add_hdds(server_id: nil, hdds: nil)
          
          # Build POST body
          new_hdds = {
            'hdds' => hdds
          }

          # Stringify the POST body
          string_body = Fog::JSON.encode(new_hdds)

          # Request
          params = {
            'method' => :post,
            'endpoint' => "/servers/#{server_id}/hardware/hdds",
            'body' => string_body
          }

          request(params)

        end

      end # Real

      
      class Mock

        def add_hdds(server_id: nil, hdds: nil)
          
          # Search for server to return
          if server = self.data[:servers].find {
            |hash| hash['id'] == server_id
          }
            # Add hdds
            hdds.each do |hdd|
              hdd['id'] = Fog::UUID.uuid
              server['hardware']['hdds'] << hdd
            end
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

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