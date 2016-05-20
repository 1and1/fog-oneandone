require_relative 'server'

module Fog
  module Compute
    class OneAndOne
      class Servers < Fog::Collection
        model Fog::Compute::OneAndOne::Server

        def all
          response = service.list_servers
          load(response.body)
        end

        def get(id)
          response = service.get_server(id)
          new(response.body)
        rescue Excon::Errors::NotFound
          nil
        end

      end # Servers
    end # OneAndOne
  end # Compute
end # Fog