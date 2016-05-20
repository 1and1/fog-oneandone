module Fog
  module Compute
    class OneAndOne
      class SharedStorage < Fog::Model

        # Declare Model Attributes
        identity  :id

        attribute :name
        attribute :description
        attribute :size
        attribute :datacenter_id
        attribute :state
        attribute :datacenter
        attribute :creation_date
        attribute :servers
        
        
        def save

          requires :name, :size

          # Perform Request
          response = service.create_shared_storage(name: name, size: size,
            description: description, datacenter_id: datacenter_id)

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def update(options = {})

          requires :id

          response = service.update_shared_storage(shared_storage_id: id,
            name: options[:name], description: options[:description],
            size: options[:size])

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def add_servers(options = {})

          requires :id

          response = service.add_shared_storage_servers(shared_storage_id: id,
            servers: options[:servers])

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def remove_server(options = {})

          requires :id

          response = service.remove_shared_storage_server(shared_storage_id: id,
            server_id: options[:server_id])

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def destroy

          requires :id

          service.delete_shared_storage(id)
          
          true

        end


        def ready?

          state == 'ACTIVE'

        end

      end # SharedStorage
    end # OneAndOne
  end # Compute
end # Fog