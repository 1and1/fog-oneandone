require_relative '../../lib/fog-oneandone'
require 'minitest/autorun'

Fog.mock!

class TestPrivateNetwork < Minitest::Test
  
  def self.test_order
   :alpha
  end

  def setup

    # Establish Connection
    @compute = Fog::Compute::OneAndOne.new({
      :oneandone_api_key => 'APIKEY'
    })

  end


  def test_a_create_private_network

    # Perform Request
    response = @compute.create_private_network(name: 'Test Private Network')
    
    @@private_network_id = response.body['id']

    # Assertions
    assert_equal response.body['name'], 'Test Private Network'

  end

  def test_b_list_private_networks
    
    # Perform Request
    response = @compute.list_private_networks

    # Assertions
    assert_equal response.body.length, 1

  end

  def test_c_update_private_network

    # Perform Request
    response = @compute.update_private_network(private_network_id: @@private_network_id,
      name: 'New Name', description: 'New Desc')

    # Assertions
    assert_equal response.body['name'], 'New Name'
    assert_equal response.body['description'], 'New Desc'

  end

  def test_d_get_private_network

    # Perform Request
    response = @compute.get_private_network(@@private_network_id)

    # Assertions
    assert_equal response.body['id'], @@private_network_id

  end

  def test_e_add_private_network_servers

    # Perform Request
    server1 = '<SERVER-ID>'

    servers = [server1]

    response = @compute.add_private_network_servers(private_network_id: @@private_network_id,
      servers: servers)

    # Assertions
    assert_equal response.body['servers'][0], '<SERVER-ID>'

  end

  def test_f_list_private_network_servers

    # Perform Request
    response = @compute.list_private_network_servers(@@private_network_id)

    # Assertions
    assert_equal response.body.length, 1

  end

  def test_g_get_private_network_server

    # Perform Request
    response = @compute.get_private_network_server(private_network_id: @@private_network_id,
      server_id: '<SERVER-ID>')

    # Assertions
    assert_equal response.body, '<SERVER-ID>'

  end

  def test_h_remove_private_network_server

    # Perform Request
    response = @compute.remove_private_network_server(private_network_id: @@private_network_id,
      server_id: '<SERVER-ID>')

    # Assertions
    assert_equal response.body['servers'].length, 0

  end

  def test_m_delete_private_network

    # Perform Request
    response = @compute.delete_private_network(@@private_network_id)

    # Assertions
    assert_equal response.body, 'The requested private network has been deleted.'

  end

end