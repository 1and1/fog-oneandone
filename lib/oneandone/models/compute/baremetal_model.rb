module Fog
  module Compute
    class OneAndOne
      class BaremetalModel < Fog::Model

        # Declare Model Attributes
        identity  :id

        attribute :name
        attribute :hardware

      end # BaremetalModel
    end # OneAndOne
  end # Compute
end # Fog
