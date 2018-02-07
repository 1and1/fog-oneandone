module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Returns information about a ssh key
        # URL: [https://cloudpanel-api.1and1.com/documentation/v1/en/api/documentation.html#ssh_keys__ssh_key_id__get]
        ##
        def get_ssh_key(ssh_key_id)
          
          params = {
            'method' => :get,
            'endpoint' => "/ssh_keys/#{ssh_key_id}"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def get_ssh_key(ssh_key_id)
          
          # Search for ssh key to return
          if ssh_key = self.data[:ssh_keys].find {
            |hash| hash['id'] == ssh_key_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 202
          response.body = ssh_key
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog