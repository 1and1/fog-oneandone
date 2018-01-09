require_relative 'ssh_key'

module Fog
  module Compute
    class OneAndOne
      class SshKeys < Fog::Collection
        model Fog::Compute::OneAndOne::SshKey

        def all
          response = service.list_ssh_keys
          load(response.body)
        end

        def get(id)
          response = service.get_ssh_key(id)
          new(response.body)
        rescue Excon::Errors::NotFound
          nil
        end

      end # SshKeys
    end # OneAndOne
  end # Compute
end # Fog