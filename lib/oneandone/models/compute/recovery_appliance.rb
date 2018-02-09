module Fog
  module Compute
    class OneAndOne
      class RecoveryAppliance < Fog::Model

        # Declare Model Attributes
        identity  :id

        attribute :name
        attribute :os_family
        attribute :os
        attribute :os_version
        attribute :os_architecture

      end # RecoveryAppliance
    end # OneAndOne
  end # Compute
end # Fog