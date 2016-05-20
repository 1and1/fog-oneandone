module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Returns information about an ISO image
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#dvd_isos__id__get]
        ##
        def get_dvd_iso(dvd_id)
          
          params = {
            'method' => :get,
            'endpoint' => "/dvd_isos/#{dvd_id}"
          }

          request(params)

        end

      end # Real

      
      class Mock

        def get_dvd_iso(dvd_id)
          
          # Search for dvd to return
          if dvd = self.data[:dvd_isos].find {
            |hash| hash['id'] == dvd_id
          }
          else
            raise Fog::Errors::NotFound.new('The requested resource could
              not be found.')
          end

          # Return Response Object to User
          response = Excon::Response.new
          response.status = 200
          response.body = dvd
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog