require_relative 'firewall'

module Fog
  module Compute
    class OneAndOne
      class Firewalls < Fog::Collection
        model Fog::Compute::OneAndOne::Firewall

        def all
          response = service.list_firewalls
          load(response.body)
        end

        def get(id)
          response = service.get_firewall(id)
          new(response.body)
        rescue Excon::Errors::NotFound
          nil
        end

      end # Firewalls
    end # OneAndOne
  end # Compute
end # Fog