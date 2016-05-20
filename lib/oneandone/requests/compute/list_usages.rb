module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Returns a list of your usages
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#usages_get]
        ##
        def list_usages(page: nil, per_page: nil, sort: nil, q: nil, fields: nil,
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
            'endpoint' => '/usages',
            'params' => query
          }

          request(params)

        end

      end # Real

      
      class Mock

        def list_usages(page: nil, per_page: nil, sort: nil, q: nil, fields: nil,
          period: 'LAST_24H', start_date: nil, end_date: nil)
          Fog::Mock.not_implemented
        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog