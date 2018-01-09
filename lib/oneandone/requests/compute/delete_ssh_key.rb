module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Returns information about a ssh key
        # URL: [https://cloudpanel-api.1and1.com/documentation/v1/en/api/documentation.html#ssh_keys__ssh_key_id__delete]
        ##
        def delete_ssh_key(ssh_key_id)
          
          params = {
            'method' => :delete,
            'endpoint' => "/ssh_keys/#{ssh_key_id}"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def delete_ssh_key(ssh_key_id)
          
          # Search for ssh key to delete
          if ssh_key = self.data[:ssh_keys].find {
            |hash| hash['id'] == ssh_key_id
          }
            self.data[:ssh_keys].delete(ssh_key)
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 202
          response.body = 'The requested ssh key has been deleted.'
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog