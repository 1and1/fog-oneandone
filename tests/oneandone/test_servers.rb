require_relative '../../lib/fog-oneandone'
require 'minitest/autorun'

Fog.mock!

class TestServer < Minitest::Test
  
  def self.test_order
   :alpha
  end

  def setup

    # Establish Connection
    @compute = Fog::Compute::OneAndOne.new({
      :oneandone_api_key => 'APIKEY'
    })

  end


  def test_a_create_server

    # Perform Request
    hdd1 = {
      'size' => 120,
      'is_main' => true
    }

    hdds = [hdd1]

    response = @compute.create_server(name: 'Test Server', vcore: 1,
      cores_per_processor: 1, ram: 1, appliance_id: '<IMAGE-ID>', hdds: hdds)
    
    @@server_id = response.body['id']
    @@ip1_id = response.body['ips'][0]['id']

    # Assertions
    assert_equal response.body['name'], 'Test Server'
    assert_equal response.body['hardware']['vcore'], 1
    assert_equal response.body['hardware']['cores_per_processor'], 1
    assert_equal response.body['hardware']['ram'], 1
    assert_equal response.body['image']['id'], '<IMAGE-ID>'

  end

  def test_b_list_servers
    
    # Perform Request
    response = @compute.list_servers

    # Assertions
    assert_equal response.body.length, 1

  end

  def test_c_update_server

    # Perform Request
    response = @compute.update_server(server_id: @@server_id,
      name: 'New Name')

    # Assertions
    assert_equal response.body['name'], 'New Name'

  end

  def test_d_get_server

    # Perform Request
    response = @compute.get_server(@@server_id)

    # Assertions
    assert_equal response.body['id'], @@server_id

  end

  def test_e_list_fixed_servers
    
    # Perform Request
    response = @compute.list_fixed_servers

    @@fixed_server_id = response.body[0]['id']

    # Assertions
    assert_equal response.body.length, 4

  end

  def test_f_get_fixed_server

    # Perform Request
    response = @compute.get_fixed_server(@@fixed_server_id)

    # Assertions
    assert_equal response.body['id'], @@fixed_server_id

  end

  def test_g_get_hardware

    # Perform Request
    response = @compute.get_hardware(@@server_id)

    # Assertions
    assert_equal response.body['vcore'], 1
    assert_equal response.body['cores_per_processor'], 1
    assert_equal response.body['ram'], 1

  end

  def test_h_update_hardware

    # Perform Request
    response = @compute.update_hardware(server_id: @@server_id, vcore: 2, ram: 4)

    # Assertions
    assert_equal response.body['hardware']['vcore'], 2
    assert_equal response.body['hardware']['ram'], 4

  end

  def test_i_get_hdds

    # Perform Request
    response = @compute.get_hdds(@@server_id)

    # Assertions
    assert_equal response.body.length, 1

  end

  def test_j_add_hdds

    # Perform Request
    hdd2 = {
      'size' => 100,
      'is_main' => false
    }

    hdds = [hdd2]

    response = @compute.add_hdds(server_id: @@server_id, hdds: hdds)

    @@hdd2_id = response.body['hardware']['hdds'][1]['id']

    # Assertions
    assert_equal response.body['hardware']['hdds'][1]['size'], 100
    assert_equal response.body['hardware']['hdds'][1]['is_main'], false
    assert_equal response.body['hardware']['hdds'].length, 2

  end

  def test_k_get_hdd

    # Perform Request
    response = @compute.get_hdd(server_id: @@server_id, hdd_id: @@hdd2_id)

    # Assertions
    assert_equal response.body['id'], @@hdd2_id
    assert_equal response.body['size'], 100
    assert_equal response.body['is_main'], false

  end

  def test_l_update_hdd

    # Perform Request
    response = @compute.update_hdd(server_id: @@server_id, hdd_id: @@hdd2_id,
      size: 200)

    # Assertions
    assert_equal response.body['hardware']['hdds'][1]['size'], 200

  end

  def test_m_delete_hdd

    # Perform Request
    response = @compute.delete_hdd(server_id: @@server_id, hdd_id: @@hdd2_id)

    # Assertions
    assert_equal response.body['hardware']['hdds'].length, 1

  end

  def test_n_get_server_image

    # Perform Request
    response = @compute.get_server_image(@@server_id)

    # Assertions
    assert_equal response.body['id'], '<IMAGE-ID>'

  end

  def test_o_install_server_image

    # Perform Request
    response = @compute.install_server_image(server_id: @@server_id,
      image_id: 'NEW-ID')

    # Assertions
    assert_equal response.body['image']['id'], 'NEW-ID'

  end

  def test_p_add_server_ip

    # Perform Request
    response = @compute.add_server_ip(server_id: @@server_id)

    @@ip2_id = response.body['ips'][1]['id']

    # Assertions
    assert_equal response.body['ips'].length, 2

  end

  def test_q_list_server_ips

    # Perform Request
    response = @compute.list_server_ips(@@server_id)

    # Assertions
    assert_equal response.body.length, 2

  end

  def test_r_get_server_ip

    # Perform Request
    response = @compute.get_server_ip(server_id: @@server_id,
      ip_id: @@ip2_id)

    # Assertions
    assert_equal response.body['id'], @@ip2_id

  end

  def test_s_delete_server_ip

    # Perform Request
    response = @compute.delete_server_ip(server_id: @@server_id,
      ip_id: @@ip2_id)

    # Assertions
    assert_equal response.body['ips'].length, 1

  end

  def test_t_list_ip_firewalls

    # Perform Request
    response = @compute.list_ip_firewalls(server_id: @@server_id,
      ip_id: @@ip1_id)

    # Assertions
    assert_equal response.body, {}

  end

  def test_u_add_firewall

    # Perform Request
    response = @compute.add_firewall(server_id: @@server_id,
      ip_id: @@ip1_id, firewall_id:'FIREWALL1')

    # Assertions
    assert_equal response.body['ips'][0]['firewall_policy']['id'], 'FIREWALL1'

  end

  def test_v_remove_firewall

    # Perform Request
    response = @compute.remove_firewall(server_id: @@server_id, ip_id: @@ip1_id)

    # Assertions
    assert_equal response.body['ips'][0]['firewall_policy'], {}

  end

  def test_w_list_ip_load_balancers

    # Perform Request
    response = @compute.list_ip_load_balancers(server_id: @@server_id,
      ip_id: @@ip1_id)

    # Assertions
    assert_equal response.body, []

  end

  def test_x_add_load_balancer

    # Perform Request
    response = @compute.add_load_balancer(server_id: @@server_id,
      ip_id: @@ip1_id, load_balancer_id: 'LB1')

    # Assertions
    assert_equal response.body['ips'][0]['load_balancers'][0]['id'], 'LB1'

  end

  def test_y_remove_load_balancer

    # Perform Request
    response = @compute.remove_load_balancer(server_id: @@server_id,
      ip_id: @@ip1_id, load_balancer_id: 'LB1')

    # Assertions
    assert_equal response.body['ips'][0]['load_balancers'].length, 0

  end

  def test_z_status

    # Perform Request
    response = @compute.status(@@server_id)

    # Assertions
    assert_equal response.body['state'], 'POWERED_ON'

  end

  def test_za_change_status

    # Perform Request
    response = @compute.change_status(server_id: @@server_id,
      action: 'POWER_OFF', method: 'SOFTWARE')

    # Assertions
    assert_equal response.body['status']['state'], 'POWERED_OFF'

  end

  def test_zb_load_dvd

    # Perform Request
    response = @compute.load_dvd(server_id: @@server_id, dvd_id: 'DVD1')

    # Assertions
    assert_equal response.body['dvd']['id'], 'DVD1'

  end

  def test_zc_get_dvd

    # Perform Request
    response = @compute.get_dvd(@@server_id)

    # Assertions
    assert_equal response.body['id'], 'DVD1'

  end

  def test_zd_eject_dvd

    # Perform Request
    response = @compute.eject_dvd(@@server_id)

    # Assertions
    assert_equal response.body['dvd'], {}

  end

  def test_ze_add_private_network

    # Perform Request
    response = @compute.add_private_network(server_id: @@server_id,
      private_network_id: 'PN1')

    # Assertions
    assert_equal response.body['private_networks'].length, 1

  end

  def test_zf_list_server_private_networks

    # Perform Request
    response = @compute.list_server_private_networks(@@server_id)

    # Assertions
    assert_equal response.body.length, 1

  end

  def test_zg_get_server_private_network

    # Perform Request
    response = @compute.get_server_private_network(server_id: @@server_id,
      private_network_id: 'PN1')

    # Assertions
    assert_equal response.body['id'], 'PN1'

  end

  def test_zh_remove_private_network

    # Perform Request
    response = @compute.remove_private_network(server_id: @@server_id,
      private_network_id: 'PN1')

    # Assertions
    assert_equal response.body['private_networks'].length, 0

  end

  def test_zi_create_snapshot

    # Perform Request
    response = @compute.create_snapshot(@@server_id)

    @@snapshot_id = response.body['snapshot']['id']

    # Assertions
    assert_equal response.body['snapshot']['id'], @@snapshot_id

  end

  def test_zj_get_snapshot

    # Perform Request
    response = @compute.get_snapshot(@@server_id)

    # Assertions
    assert_equal response.body['id'], @@snapshot_id

  end

  def test_zk_delete_snapshot

    # Perform Request
    response = @compute.delete_snapshot(server_id: @@server_id,
      snapshot_id: @@snapshot_id)

    # Assertions
    assert_equal response.body['snapshot'], {}

  end

  def test_zl_clone_server

    # Perform Request
    response = @compute.clone_server(server_id: @@server_id,
      name: 'Mini Me')

    # Assertions
    assert_equal response.body['name'], 'Mini Me'

  end

  def test_zm_delete_server

    # Perform Request
    response = @compute.delete_server(@@server_id)

    # Assertions
    assert_equal response.body, 'The requested server has been deleted.'

  end

end