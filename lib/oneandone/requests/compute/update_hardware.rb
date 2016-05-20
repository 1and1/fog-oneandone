module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Returns information about a server's current hardware configurations
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#servers__server_id__hardware_get]
        ##
        def update_hardware(server_id: nil, fixed_instance_id: nil, vcore: nil,
          cores_per_processor: nil, ram: nil)
          
          # Build PUT body
          hardware_specs = {
            'fixed_instance_size_id' => fixed_instance_id,
            'vcore' => vcore,
            'cores_per_processor' => cores_per_processor,
            'ram' => ram
          }

          # Clean out null keys in PUT body
          body = clean_hash(hardware_specs)

          # Stringify the PUT body
          string_body = Fog::JSON.encode(body)

          # Request
          params = {
            'method' => :put,
            'endpoint' => "/servers/#{server_id}/hardware",
            'body' => string_body
          }

          request(params)

        end

      end # Real

      
      class Mock

        def update_hardware(server_id: nil, fixed_instance_id: nil, vcore: nil,
          cores_per_processor: nil, ram: nil)
          
          # Search for server to update
          if server = self.data[:servers].find {
            |hash| hash['id'] == server_id
          }
            # Create parameter hash 
            params = {
              'fixed_instance_id' => fixed_instance_id,
              'vcore' => vcore,
              'cores_per_processor' => cores_per_processor,
              'ram' => ram
            }
            
            # Update the server hardware with new values
            params.each do |key, value|
              if value
                server['hardware'][key] = value
              end
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