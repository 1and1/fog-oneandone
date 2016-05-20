module Fog
  module Compute
    class OneAndOne
      class Vpn < Fog::Model

        # Declare Model Attributes
        identity  :id

        attribute :name
        attribute :description
        attribute :datacenter
        attribute :datacenter_id
        attribute :state
        attribute :type
        attribute :ips
        attribute :creation_date
        
        
        def save

          requires :name

          # Perform Request
          response = service.create_vpn(name: name, description: description,
            datacenter_id: datacenter_id)

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def update(options = {})

          requires :id

          response = service.update_vpn(vpn_id: id, name: options[:name],
            description: options[:description])

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def destroy

          requires :id

          service.delete_vpn(id)
          
          true

        end


        def ready?

          state == 'ACTIVE'

        end

      end # Vpn
    end # OneAndOne
  end # Compute
end # Fog