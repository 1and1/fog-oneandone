require_relative '../../lib/fog-oneandone'
require 'minitest/autorun'

Fog.mock!

class TestRecoveryAppliance < Minitest::Test
  def self.test_order
   :alpha
  end

  def setup
    # Establish Connection
    @compute = Fog::Compute::OneAndOne.new({
      :oneandone_api_key => 'APIKEY'
    })
  end

  def test_a_list_recovery_appliances
    # Perform Request
    response = @compute.list_recovery_appliances

    @@appliance_id = response.body[0]['id']
    # Assertions
    assert_equal response.body.length, 2
  end

  def test_b_get_recovery_appliance
    # Perform Request
    response = @compute.get_recovery_appliance(@@appliance_id)

    # Assertions
    assert_equal response.body['id'], @@appliance_id
  end
end