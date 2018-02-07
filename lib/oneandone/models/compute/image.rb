module Fog
  module Compute
    class OneAndOne
      class Image < Fog::Model

        # Declare Model Attributes
        identity  :id

        attribute :name
        attribute :description
        attribute :datacenter
        attribute :min_hdd_size
        attribute :state
        attribute :hdds
        attribute :server_id
        attribute :frequency
        attribute :num_images
        attribute :creation_date
        attribute :source
        attribute :url
        attribute :os_id
        attribute :type
        
        
        def save

          requires :name, :server_id, :frequency, :num_images

          # Perform Request
          response = service.create_image(name: name, description: description,
            server_id: server_id, frequency: frequency, num_images: num_images,
            source: source, url: url, os_id: os_id, type: type)

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def update(options = {})

          requires :id

          response = service.update_image(image_id: id, name: options[:name],
            description: options[:description], frequency: options[:frequency])

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def destroy

          requires :id

          service.delete_image(id)
          
          true

        end


        def ready?

          state == 'ENABLED'

        end

      end # Image
    end # OneAndOne
  end # Compute
end # Fog