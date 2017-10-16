require_relative 'recovery_appliance'

module Fog
  module Compute
    class OneAndOne
      class RecoveryAppliances < Fog::Collection
        model Fog::Compute::OneAndOne::RecoveryAppliance

        def all
          response = service.list_recovery_appliances
          load(response.body)
        end

        def get(id)
          response = service.get_recovery_appliance(id)
          new(response.body)
        rescue Excon::Errors::NotFound
          nil
        end

      end # RecoveryAppliances
    end # OneAndOne
  end # Compute
end # Fog