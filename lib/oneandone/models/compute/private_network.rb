module Fog
  module Compute
    class OneAndOne
      class PrivateNetwork < Fog::Model

        # Declare Model Attributes
        identity  :id

        attribute :name
        attribute :description
        attribute :datacenter_id
        attribute :network_address
        attribute :subnet_mask
        
        attribute :state
        attribute :creation_date
        attribute :datacenter
        attribute :servers
        
        
        def save

          requires :name

          # Perform Request
          response = service.create_private_network(name: name,
            description: description, network_address: network_address,
            subnet_mask: subnet_mask, datacenter_id: datacenter_id)

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def update(options = {})

          requires :id

          response = service.update_private_network(private_network_id: id,
            name: options[:name], description: options[:description],
            network_address: options[:network_address],
            subnet_mask: options[:subnet_mask])

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def add_servers(options = {})

          requires :id

          response = service.add_private_network_servers(private_network_id: id,
            servers: options[:servers])

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def remove_server(options = {})

          requires :id

          response = service.remove_private_network_server(private_network_id: id,
            server_id: options[:server_id])

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def destroy

          requires :id

          service.delete_private_network(id)
          
          true

        end


        def ready?

          state == 'ACTIVE'

        end

      end # PrivateNetwork
    end # OneAndOne
  end # Compute
end # Fog