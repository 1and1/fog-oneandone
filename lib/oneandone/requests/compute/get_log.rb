module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Returns information about a log
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#logs__log_id__get]
        ##
        def get_log(log_id)

          # Request
          params = {
            'method' => :get,
            'endpoint' => "/logs/#{log_id}"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def get_log(log_id)
          
          # Search for log to return
          if log = self.data[:logs].find {
            |hash| hash['id'] == log_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 200
          response.body = log
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog