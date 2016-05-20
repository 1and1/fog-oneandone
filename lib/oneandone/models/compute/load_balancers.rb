require_relative 'load_balancer'

module Fog
  module Compute
    class OneAndOne
      class LoadBalancers < Fog::Collection
        model Fog::Compute::OneAndOne::LoadBalancer

        def all
          response = service.list_load_balancers
          load(response.body)
        end

        def get(id)
          response = service.get_load_balancer(id)
          new(response.body)
        rescue Excon::Errors::NotFound
          nil
        end

      end # LoadBalancers
    end # OneAndOne
  end # Compute
end # Fog