require_relative 'block_storage'

module Fog
  module Compute
    class OneAndOne
      class BlockStorages < Fog::Collection
        model Fog::Compute::OneAndOne::BlockStorage

        def all
          response = service.list_block_storages
          load(response.body)
        end

        def get(id)
          response = service.get_block_storage(id)
          new(response.body)
        rescue Excon::Errors::NotFound
          nil
        end

      end # BlockStorages
    end # OneAndOne
  end # Compute
end # Fog