module Fog
  module Compute
    class OneAndOne
      class SshKey < Fog::Model

        # Declare Model Attributes
        identity  :id

        attribute :name
        attribute :description
        attribute :state
        attribute :servers
        attribute :md5
        attribute :public_key
        attribute :creation_date

        
        def save

          # Perform Request
          response = service.create_ssh_key(name: name, description: description,
            public_key: public_key)

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def update(options = {})

          requires :id

          response = service.update_ssh_key(ssh_key_id: id,
            name: options[:name], description: options[:description])

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def destroy

          requires :id

          service.delete_ssh_key(id)
          
          true

        end


        def ready?

          state == 'ACTIVE'

        end

      end # SshKey
    end # OneAndOne
  end # Compute
end # Fog