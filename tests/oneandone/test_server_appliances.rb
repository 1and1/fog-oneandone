require_relative '../../lib/fog-oneandone'
require 'minitest/autorun'

Fog.mock!

class TestServerAppliance < Minitest::Test
  def self.test_order
    :alpha
  end

  def setup
    # Establish Connection
    @compute = Fog::Compute::OneAndOne.new({
      :oneandone_api_key => 'APIKEY'
    })
  end

  def test_a_list_server_appliances
    # Perform Request
    response = @compute.list_server_appliances

    @@appliance_id = response.body[0]['id']
    # Assertions
    assert_equal response.body.length, 2
  end

  def test_b_get_server_appliance
    # Perform Request
    response = @compute.get_server_appliance(@@appliance_id)

    # Assertions
    assert_equal response.body['id'], @@appliance_id
  end
end