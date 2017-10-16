require_relative 'server_appliance'

module Fog
  module Compute
    class OneAndOne
      class ServerAppliances < Fog::Collection
        model Fog::Compute::OneAndOne::ServerAppliance

        def all
          response = service.list_server_appliances
          load(response.body)
        end

        def get(id)
          response = service.get_server_appliance(id)
          new(response.body)
        rescue Excon::Errors::NotFound
          nil
        end

      end # ServerAppliances
    end # OneAndOne
  end # Compute
end # Fog