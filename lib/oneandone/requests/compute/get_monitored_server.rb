module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Returns information about a monitoring server for a specified time range
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#monitoring_center__server_id__get]
        ##
        def get_monitored_server(server_id: nil, period: 'LAST_24H',
          start_date: nil, end_date: nil)
          
          # Build hash for query parameters
          keyword_args = {
            :period => period,
            :start_date => start_date,
            :end_date => end_date
          }

          # Clean out null query parameters
          query = clean_hash(keyword_args)

          # Request
          params = {
            'method' => :get,
            'endpoint' => "/monitoring_center/#{server_id}",
            'params' => query
          }

          request(params)

        end

      end # Real

      
      class Mock

        def get_monitored_server(server_id: nil, period: 'LAST24H',
          start_date: nil, end_date: nil)
          Fog::Mock.not_implemented
        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog