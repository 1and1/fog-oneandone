require_relative 'private_network'

module Fog
  module Compute
    class OneAndOne
      class PrivateNetworks < Fog::Collection
        model Fog::Compute::OneAndOne::PrivateNetwork

        def all
          response = service.list_private_networks
          load(response.body)
        end

        def get(id)
          response = service.get_private_network(id)
          new(response.body)
        rescue Excon::Errors::NotFound
          nil
        end

      end # PrivateNetworks
    end # OneAndOne
  end # Compute
end # Fog