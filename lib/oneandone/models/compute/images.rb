require_relative 'image'

module Fog
  module Compute
    class OneAndOne
      class Images < Fog::Collection
        model Fog::Compute::OneAndOne::Image

        def all
          response = service.list_images
          load(response.body)
        end

        def get(id)
          response = service.get_image(id)
          new(response.body)
        rescue Excon::Errors::NotFound
          nil
        end

      end # Images
    end # OneAndOne
  end # Compute
end # Fog