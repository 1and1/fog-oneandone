module Fog
  module Compute
    class OneAndOne
      class BlockStorage < Fog::Model

        # Declare Model Attributes
        identity  :id

        attribute :size
        attribute :state
        attribute :description
        attribute :name
        attribute :datacenter_id
        attribute :datacenter
        attribute :creation_date
        attribute :server
        attribute :server_id

        
        def save

          # Perform Request
          response = service.create_block_storage(name: name, size: size,
            description: description, datacenter_id: datacenter_id,
            server_id: server_id)

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def update(options = {})

          requires :id

          response = service.update_block_storage(block_storage_id: id,
            name: options[:name], description: options[:description],
            size: options[:size])

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def add_server(options = {})

          requires :id

          response = service.add_block_storage_server(block_storage_id: id,
            server_id: options[:server_id])

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def remove_server()

          requires :id

          response = service.remove_block_storage_server(block_storage_id: id)

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def destroy

          requires :id

          service.delete_block_storage(id)
          
          true

        end


        def ready?

          state == 'POWERED_ON'

        end

      end # BlockStorage
    end # OneAndOne
  end # Compute
end # Fog