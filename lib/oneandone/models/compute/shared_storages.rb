require_relative 'shared_storage'

module Fog
  module Compute
    class OneAndOne
      class SharedStorages < Fog::Collection
        model Fog::Compute::OneAndOne::SharedStorage

        def all
          response = service.list_shared_storages
          load(response.body)
        end

        def get(id)
          response = service.get_shared_storage(id)
          new(response.body)
        rescue Excon::Errors::NotFound
          nil
        end

      end # SharedStorages
    end # OneAndOne
  end # Compute
end # Fog