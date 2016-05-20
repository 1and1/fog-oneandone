require_relative '../../lib/fog-oneandone'
require 'minitest/autorun'

Fog.mock!

class TestLoadBalancer < Minitest::Test
  
  def self.test_order
   :alpha
  end

  def setup

    # Establish Connection
    @compute = Fog::Compute::OneAndOne.new({
      :oneandone_api_key => 'APIKEY'
    })

  end


  def test_a_create_load_balancer

    # Perform Request
    rule1 = {
      'protocol' => 'TCP',
      'port_balancer' => 80,
      'port_server' => 80,
      'source' => '0.0.0.0'
    }

    rules = [rule1]

    response = @compute.create_load_balancer(name: 'Test LB',
      description: 'Example Desc', health_check_test: 'TCP',
      health_check_interval: 40, persistence: true, persistence_time: 1200,
      method: 'ROUND_ROBIN', rules: rules)
    
    @@load_balancer_id = response.body['id']

    # Assertions
    assert_equal response.body['name'], 'Test LB'
    assert_equal response.body['description'], 'Example Desc'
    assert_equal response.body['health_check_test'], 'TCP'
    assert_equal response.body['health_check_interval'], 40

  end

  def test_b_list_load_balancers
    
    # Perform Request
    response = @compute.list_load_balancers

    # Assertions
    assert_equal response.body.length, 1

  end

  def test_c_update_load_balancer

    # Perform Request
    response = @compute.update_load_balancer(load_balancer_id: @@load_balancer_id,
      name: 'New Name', description: 'New Desc')

    # Assertions
    assert_equal response.body['name'], 'New Name'
    assert_equal response.body['description'], 'New Desc'

  end

  def test_d_get_load_balancer

    # Perform Request
    response = @compute.get_load_balancer(@@load_balancer_id)

    # Assertions
    assert_equal response.body['id'], @@load_balancer_id

  end

  def test_e_add_load_balancer_ips

    # Perform Request
    ip1 = '<IP-ID>'

    ips = [ip1]

    response = @compute.add_load_balancer_ips(load_balancer_id: @@load_balancer_id,
      ips: ips)

    # Assertions
    assert_equal response.body['server_ips'][0], '<IP-ID>'

  end

  def test_f_list_load_balancer_ips

    # Perform Request
    response = @compute.list_load_balancer_ips(@@load_balancer_id)

    # Assertions
    assert_equal response.body.length, 1

  end

  def test_g_get_load_balancer_ip

    # Perform Request
    response = @compute.get_load_balancer_ip(load_balancer_id: @@load_balancer_id,
      ip_id: '<IP-ID>')

    # Assertions
    assert_equal response.body, '<IP-ID>'

  end

  def test_h_remove_load_balancer_ip

    # Perform Request
    response = @compute.remove_load_balancer_ip(load_balancer_id: @@load_balancer_id,
      ip_id: '<IP-ID>')

    # Assertions
    assert_equal response.body['server_ips'].length, 0

  end

  def test_i_add_load_balancer_rules

    # Perform Request
    rule2 = {
      'protocol' => 'TCP',
      'port_balancer' => 90,
      'port_server' => 90,
      'source' => '0.0.0.0'
    }

    rules = [rule2]

    response = @compute.add_load_balancer_rules(load_balancer_id: @@load_balancer_id,
      rules: rules)

    @@rule2_id = response.body['rules'][1]['id']

    # Assertions
    assert_equal response.body['rules'][1]['port_balancer'], 90

  end

  def test_j_list_load_balancer_rules

    # Perform Request
    response = @compute.list_load_balancer_rules(@@load_balancer_id)

    # Assertions
    assert_equal response.body.length, 2

  end

  def test_k_get_load_balancer_rule

    # Perform Request
    response = @compute.get_load_balancer_rule(load_balancer_id: @@load_balancer_id,
      rule_id: @@rule2_id)

    # Assertions
    assert_equal response.body['id'], @@rule2_id

  end

  def test_l_delete_load_balancer_rule

    # Perform Request
    response = @compute.delete_load_balancer_rule(load_balancer_id: @@load_balancer_id,
      rule_id: @@rule2_id)

    # Assertions
    assert_equal response.body['rules'].length, 1

  end

  def test_m_delete_load_balancer

    # Perform Request
    response = @compute.delete_load_balancer(@@load_balancer_id)

    # Assertions
    assert_equal response.body, 'The requested load balancer has been deleted.'

  end

end