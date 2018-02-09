require_relative 'baremetal_model'

module Fog
  module Compute
    class OneAndOne
      class BaremetalModels < Fog::Collection
        model Fog::Compute::OneAndOne::BaremetalModel

        def all
          response = service.list_baremetal_models
          load(response.body)
        end

        def get(id)
          response = service.get_server(id)
          new(response.body)
        rescue Excon::Errors::NotFound
          nil
        end

      end # BaremetalModels
    end # OneAndOne
  end # Compute
end # Fog