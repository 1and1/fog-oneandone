module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Returns a list with logs
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#logs_get]
        ##
        def list_logs(page: nil, per_page: nil, sort: nil, q: nil, fields: nil,
          period: 'LAST_24H', start_date: nil, end_date: nil)
          
          # Build hash for query parameters
          keyword_args = {
            :page => page,
            :per_page => per_page,
            :sort => sort,
            :q => q,
            :fields => fields,
            :period => period,
            :start_date => start_date,
            :end_date => end_date
          }

          # Clean out null query parameters
          query = clean_hash(keyword_args)

          # Request
          params = {
            'method' => :get,
            'endpoint' => '/logs',
            'params' => query
          }

          request(params)

        end

      end # Real

      
      class Mock

        def list_logs(page: nil, per_page: nil, sort: nil, q: nil, fields: nil,
          period: 'LAST_24H', start_date: nil, end_date: nil)
          
          response = Excon::Response.new
          response.status = 200
          response.body = self.data[:logs]
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog