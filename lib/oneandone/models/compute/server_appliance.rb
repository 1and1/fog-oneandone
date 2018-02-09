module Fog
  module Compute
    class OneAndOne
      class ServerAppliance < Fog::Model

        # Declare Model Attributes
        identity  :id

        attribute :name
        attribute :os_family
        attribute :os
        attribute :os_version
        attribute :os_architecture
        attribute :os_image_type
        attribute :type
        attribute :server_type_compatibility
        attribute :min_hdd_size
        attribute :licenses
        attribute :version
        attribute :categories

      end # ServerAppliance
    end # OneAndOne
  end # Compute
end # Fog