require_relative 'vpn'

module Fog
  module Compute
    class OneAndOne
      class Vpns < Fog::Collection
        model Fog::Compute::OneAndOne::Vpn

        def all
          response = service.list_vpns
          load(response.body)
        end

        def get(id)
          response = service.get_vpn(id)
          new(response.body)
        rescue Excon::Errors::NotFound
          nil
        end

      end # Vpns
    end # OneAndOne
  end # Compute
end # Fog