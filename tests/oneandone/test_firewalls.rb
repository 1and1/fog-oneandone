require_relative '../../lib/fog-oneandone'
require 'minitest/autorun'

Fog.mock!

class TestFirewall < Minitest::Test
  
  def self.test_order
   :alpha
  end

  def setup

    # Establish Connection
    @compute = Fog::Compute::OneAndOne.new({
      :oneandone_api_key => 'APIKEY'
    })

  end


  def test_a_create_firewall

    # Perform Request
    rule1 = {
      'protocol' => 'TCP',
      'port_from' => 80,
      'port_to' => 80,
      'source' => '0.0.0.0'
    }

    rules = [rule1]

    response = @compute.create_firewall(name: 'Test Firewall',
      description: 'Example Desc', rules: rules)
    
    @@firewall_id = response.body['id']

    # Assertions
    assert_equal response.body['name'], 'Test Firewall'
    assert_equal response.body['description'], 'Example Desc'

  end

  def test_b_list_firewalls
    
    # Perform Request
    response = @compute.list_firewalls

    # Assertions
    assert_equal response.body.length, 1

  end

  def test_c_update_firewall

    # Perform Request
    response = @compute.update_firewall(firewall_id: @@firewall_id,
      name: 'New Name', description: 'New Desc')

    # Assertions
    assert_equal response.body['name'], 'New Name'
    assert_equal response.body['description'], 'New Desc'

  end

  def test_d_get_firewall

    # Perform Request
    response = @compute.get_firewall(@@firewall_id)

    # Assertions
    assert_equal response.body['id'], @@firewall_id

  end

  def test_e_add_firewall_ips

    # Perform Request
    ip1 = '<IP-ID>'

    ips = [ip1]

    response = @compute.add_firewall_ips(firewall_id: @@firewall_id,
      ips: ips)

    # Assertions
    assert_equal response.body['server_ips'][0], '<IP-ID>'

  end

  def test_f_list_firewall_ips

    # Perform Request
    response = @compute.list_firewall_ips(@@firewall_id)

    # Assertions
    assert_equal response.body.length, 1

  end

  def test_g_get_firewall_ip

    # Perform Request
    response = @compute.get_firewall_ip(firewall_id: @@firewall_id,
      ip_id: '<IP-ID>')

    # Assertions
    assert_equal response.body, '<IP-ID>'

  end

  def test_h_remove_firewall_ip

    # Perform Request
    response = @compute.remove_firewall_ip(firewall_id: @@firewall_id,
      ip_id: '<IP-ID>')

    # Assertions
    assert_equal response.body['server_ips'].length, 0

  end

  def test_i_add_firewall_rules

    # Perform Request
    rule2 = {
      'protocol' => 'TCP',
      'port_from' => 90,
      'port_to' => 90,
      'source' => '0.0.0.0'
    }

    rules = [rule2]

    response = @compute.add_firewall_rules(firewall_id: @@firewall_id,
      rules: rules)

    @@rule2_id = response.body['rules'][1]['id']

    # Assertions
    assert_equal response.body['rules'][1]['port_from'], 90

  end

  def test_j_list_firewall_rules

    # Perform Request
    response = @compute.list_firewall_rules(@@firewall_id)

    # Assertions
    assert_equal response.body.length, 2

  end

  def test_k_get_firewall_rule

    # Perform Request
    response = @compute.get_firewall_rule(firewall_id: @@firewall_id,
      rule_id: @@rule2_id)

    # Assertions
    assert_equal response.body['id'], @@rule2_id

  end

  def test_l_delete_firewall_rule

    # Perform Request
    response = @compute.delete_firewall_rule(firewall_id: @@firewall_id,
      rule_id: @@rule2_id)

    # Assertions
    assert_equal response.body['rules'].length, 1

  end

  def test_m_delete_firewall

    # Perform Request
    response = @compute.delete_firewall(@@firewall_id)

    # Assertions
    assert_equal response.body, 'The requested firewall has been deleted.'

  end

end