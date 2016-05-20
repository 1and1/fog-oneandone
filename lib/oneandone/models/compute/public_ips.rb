require_relative 'public_ip'

module Fog
  module Compute
    class OneAndOne
      class PublicIps < Fog::Collection
        model Fog::Compute::OneAndOne::PublicIp

        def all
          response = service.list_public_ips
          load(response.body)
        end

        def get(id)
          response = service.get_public_ip(id)
          new(response.body)
        rescue Excon::Errors::NotFound
          nil
        end

      end # PublicIps
    end # OneAndOne
  end # Compute
end # Fog