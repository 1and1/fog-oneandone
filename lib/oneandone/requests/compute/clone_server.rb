module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Clone a server
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#servers__server_id__clone_post]
        ##
        def clone_server(server_id: nil, name: nil, datacenter_id: nil)
          
          # Build PUT body
          clone_specs = {
            'name' => name,
            'datacenter_id' => datacenter_id
          }

          # Stringify the PUT body
          string_body = Fog::JSON.encode(clone_specs)

          # Request
          params = {
            'method' => :post,
            'endpoint' => "/servers/#{server_id}/clone",
            'body' => string_body
          }

          request(params)

        end

      end # Real

      
      class Mock

        def clone_server(server_id: nil, name: nil, datacenter_id: nil)
          
          # Search for server
          if server = self.data[:servers].find {
            |hash| hash['id'] == server_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Clone server and save to servers list
          clone = server.dup
          clone['id'] = Fog::UUID.uuid
          clone['name'] = name
          self.data[:servers] << clone

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 202
          response.body = clone
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog