require_relative '../../lib/fog-oneandone'
require 'minitest/autorun'

Fog.mock!

class TestMonitoringPolicy < Minitest::Test
  
  def self.test_order
   :alpha
  end

  def setup

    # Establish Connection
    @compute = Fog::Compute::OneAndOne.new({
      :oneandone_api_key => 'APIKEY'
    })

  end


  def test_a_create_monitoring_policy

    # Perform Request
    thresholds = {
      'cpu' => {
        'warning' => {
          'value' => 90,
          'alert' => false
        },
        'critical' => {
          'value' => 95,
          'alert' => false
        }
      },
      'ram' => {
        'warning' => {
          'value' => 90,
          'alert' => false
        },
        'critical' => {
          'value' => 95,
          'alert' => false
        }
      },
      'disk' => {
        'warning' => {
          'value' => 90,
          'alert' => false
        },
        'critical' => {
          'value' => 95,
          'alert' => false
        }
      },
      'transfer' => {
        'warning' => {
          'value' => 1000,
          'alert' => false
        },
        'critical' => {
          'value' => 2000,
          'alert' => false
        }
      },
      'internal_ping' => {
        'warning' => {
          'value' => 50,
          'alert' => false
        },
        'critical' => {
          'value' => 100,
          'alert' => false
        }
      }
    }

    port1 = {
      'protocol' => 'TCP',
      'port' => 80,
      'alert_if' => 'NOT_RESPONDING',
      'email_notification' => true
    }

    ports = [port1]

    process1 = {
      'process' => 'test',
      'alert_if' => 'NOT_RUNNING',
      'email_notification' => true
    }

    processes = [process1]

    response = @compute.create_monitoring_policy(name: 'Test Monitoring Policy',
      email: 'test@example.com', agent: true, thresholds: thresholds,
      ports: ports, processes: processes)
    
    @@monitoring_policy_id = response.body['id']

    # Assertions
    assert_equal response.body['name'], 'Test Monitoring Policy'
    assert_equal response.body['email'], 'test@example.com'
    assert_equal response.body['agent'], true

  end

  def test_b_list_monitoring_policies
    
    # Perform Request
    response = @compute.list_monitoring_policies

    # Assertions
    assert_equal response.body.length, 1

  end

  def test_c_update_monitoring_policy

    # Perform Request
    response = @compute.update_monitoring_policy(monitoring_policy_id: @@monitoring_policy_id,
      name: 'New Name', description: 'New Desc', email: 'new@example.com')

    # Assertions
    assert_equal response.body['name'], 'New Name'
    assert_equal response.body['description'], 'New Desc'
    assert_equal response.body['email'], 'new@example.com'

  end

  def test_d_get_monitoring_policy

    # Perform Request
    response = @compute.get_monitoring_policy(@@monitoring_policy_id)

    # Assertions
    assert_equal response.body['id'], @@monitoring_policy_id

  end

  def test_e_add_ports

    # Perform Request
    port2 = {
      'protocol' => 'TCP',
      'port' => 90,
      'alert_if' => 'NOT_RESPONDING',
      'email_notification' => true
    }

    ports = [port2]

    response = @compute.add_ports(monitoring_policy_id: @@monitoring_policy_id,
      ports: ports)

    @@port2_id = response.body['ports'][1]['id']

    # Assertions
    assert_equal response.body['ports'].length, 2

  end

  def test_f_list_ports

    # Perform Request
    response = @compute.list_ports(@@monitoring_policy_id)

    # Assertions
    assert_equal response.body.length, 2

  end

  def test_g_get_port

    # Perform Request
    response = @compute.get_port(monitoring_policy_id: @@monitoring_policy_id,
      port_id: @@port2_id)

    # Assertions
    assert_equal response.body['id'], @@port2_id

  end

  def test_h_update_port

    # Perform Request
    port = {
      'protocol' => 'TCP',
      'port' => 80,
      'alert_if' => 'RESPONDING',
      'email_notification' => false
    }

    response = @compute.update_port(monitoring_policy_id: @@monitoring_policy_id,
      port_id: @@port2_id, new_port: port)

    # Assertions
    assert_equal response.body['ports'][1]['alert_if'], 'RESPONDING'
    assert_equal response.body['ports'][1]['email_notification'], false

  end

  def test_i_delete_port

    # Perform Request
    response = @compute.delete_port(monitoring_policy_id: @@monitoring_policy_id,
      port_id: @@port2_id)

    # Assertions
    assert_equal response.body['ports'].length, 1

  end

  def test_j_add_processes

    # Perform Request
    process2 = {
      'process' => 'logger',
      'alert_if' => 'NOT_RUNNING',
      'email_notification' => true
    }

    processes = [process2]

    response = @compute.add_processes(monitoring_policy_id: @@monitoring_policy_id,
      processes: processes)

    @@process2_id = response.body['processes'][1]['id']

    # Assertions
    assert_equal response.body['processes'].length, 2

  end

  def test_k_list_processes

    # Perform Request
    response = @compute.list_processes(@@monitoring_policy_id)

    # Assertions
    assert_equal response.body.length, 2

  end

  def test_l_get_process

    # Perform Request
    response = @compute.get_process(monitoring_policy_id: @@monitoring_policy_id,
      process_id: @@process2_id)

    # Assertions
    assert_equal response.body['id'], @@process2_id

  end

  def test_m_update_process

    # Perform Request
    process = {
      'process' => 'test',
      'alert_if' => 'RUNNING',
      'email_notification' => false
    }

    response = @compute.update_process(monitoring_policy_id: @@monitoring_policy_id,
      process_id: @@process2_id, new_process: process)

    # Assertions
    assert_equal response.body['processes'][1]['alert_if'], 'RUNNING'
    assert_equal response.body['processes'][1]['email_notification'], false

  end

  def test_n_delete_process

    # Perform Request
    response = @compute.delete_process(monitoring_policy_id: @@monitoring_policy_id,
      process_id: @@process2_id)

    # Assertions
    assert_equal response.body['processes'].length, 1

  end

  def test_o_add_mp_servers

    # Perform Request
    server1 = '<SERVER-ID>'

    servers = [server1]

    response = @compute.add_mp_servers(monitoring_policy_id: @@monitoring_policy_id,
      servers: servers)

    # Assertions
    assert_equal response.body['servers'][0], '<SERVER-ID>'

  end

  def test_p_list_mp_servers

    # Perform Request
    response = @compute.list_mp_servers(@@monitoring_policy_id)

    # Assertions
    assert_equal response.body.length, 1

  end

  def test_q_get_mp_server

    # Perform Request
    response = @compute.get_mp_server(monitoring_policy_id: @@monitoring_policy_id,
      server_id: '<SERVER-ID>')

    # Assertions
    assert_equal response.body, '<SERVER-ID>'

  end

  def test_r_remove_mp_server

    # Perform Request
    response = @compute.remove_mp_server(monitoring_policy_id: @@monitoring_policy_id,
      server_id: '<SERVER-ID>')

    # Assertions
    assert_equal response.body['servers'].length, 0

  end

  def test_s_delete_monitoring_policy

    # Perform Request
    response = @compute.delete_monitoring_policy(@@monitoring_policy_id)

    # Assertions
    assert_equal response.body, 'The requested monitoring policy has been deleted.'

  end

end