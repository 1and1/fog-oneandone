require_relative '../../lib/fog-oneandone'
require 'minitest/autorun'

Fog.mock!

class TestPublicIP < Minitest::Test
  
  def self.test_order
   :alpha
  end

  def setup

    # Establish Connection
    @compute = Fog::Compute::OneAndOne.new({
      :oneandone_api_key => 'APIKEY'
    })

  end


  def test_a_create_public_ip

    # Perform Request
    response = @compute.create_public_ip
    
    @@ip_id = response.body['id']

    # Assertions
    assert_equal response.body['state'], 'ACTIVE'

  end

  def test_b_list_public_ips
    
    # Perform Request
    response = @compute.list_public_ips

    # Assertions
    assert_equal response.body.length, 1

  end

  def test_c_update_public_ip

    # Perform Request
    response = @compute.update_public_ip(ip_id: @@ip_id,
      reverse_dns: 'example.com')

    # Assertions
    assert_equal response.body['reverse_dns'], 'example.com'

  end

  def test_d_get_public_ip

    # Perform Request
    response = @compute.get_public_ip(@@ip_id)

    # Assertions
    assert_equal response.body['id'], @@ip_id

  end

  def test_e_delete_public_ip

    # Perform Request
    response = @compute.delete_public_ip(@@ip_id)

    # Assertions
    assert_equal response.body, 'The requested public IP has been deleted.'

  end

end