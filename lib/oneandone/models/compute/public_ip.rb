module Fog
  module Compute
    class OneAndOne
      class PublicIp < Fog::Model

        # Declare Model Attributes
        identity  :id

        attribute :type
        attribute :reverse_dns
        attribute :datacenter_id
        attribute :datacenter
        attribute :ip
        attribute :assigned_to
        attribute :state
        attribute :creation_date
        
        
        def save

          # Perform Request
          response = service.create_public_ip(type: type,
            reverse_dns: reverse_dns, datacenter_id: datacenter_id)

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def update(options = {})

          requires :id

          response = service.update_public_ip(ip_id: id,
            reverse_dns: options[:reverse_dns])

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def destroy

          requires :id

          service.delete_public_ip(id)
          
          true

        end


        def ready?

          state == 'ACTIVE'

        end

      end # PublicIp
    end # OneAndOne
  end # Compute
end # Fog