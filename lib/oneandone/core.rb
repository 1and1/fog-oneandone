require "fog/core"
require "fog/json"

module Fog
  module OneAndOne
    extend Fog::Provider

    service(:compute, 'Compute')

  end # OneAndOne
end # Fog