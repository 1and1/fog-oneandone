require_relative '../../lib/fog-oneandone'
require 'minitest/autorun'

Fog.mock!

class TestSharedStorage < Minitest::Test

  def self.test_order
   :alpha
  end

  def setup

    # Establish Connection
    @compute = Fog::Compute::OneAndOne.new({
      :oneandone_api_key => 'APIKEY'
    })

  end


  def test_a_create_shared_storage

    # Perform Request
    response = @compute.create_shared_storage(name: 'Test SS',
      description: 'Example Desc', size: 200)
    
    @@shared_storage_id = response.body['id']

    # Assertions
    assert_equal response.body['name'], 'Test SS'
    assert_equal response.body['description'], 'Example Desc'
    assert_equal response.body['size'], 200

  end

  def test_b_list_shared_storages
    
    # Perform Request
    response = @compute.list_shared_storages

    # Assertions
    assert_equal response.body.length, 1

  end

  def test_c_update_shared_storage

    # Perform Request
    response = @compute.update_shared_storage(shared_storage_id: @@shared_storage_id,
      name: 'New Name', description: 'New Desc')

    # Assertions
    assert_equal response.body['name'], 'New Name'
    assert_equal response.body['description'], 'New Desc'

  end

  def test_d_get_shared_storage

    # Perform Request
    response = @compute.get_shared_storage(@@shared_storage_id)

    # Assertions
    assert_equal response.body['id'], @@shared_storage_id

  end

  def test_e_add_shared_storage_servers

    # Perform Request
    server1 = {
      'id' => '<SERVER-ID>',
      'rights' => 'RW'
    }

    servers = [server1]

    response = @compute.add_shared_storage_servers(shared_storage_id: @@shared_storage_id,
      servers: servers)

    @@server1 = response.body['servers'][0]['id']

    # Assertions
    assert_equal response.body['servers'].length, 1

  end

  def test_f_list_shared_storage_servers

    # Perform Request
    response = @compute.list_shared_storage_servers(@@shared_storage_id)

    # Assertions
    assert_equal response.body.length, 1

  end

  def test_g_get_shared_storage_server

    # Perform Request
    response = @compute.get_shared_storage_server(shared_storage_id: @@shared_storage_id,
      server_id: @@server1)

    # Assertions
    assert_equal response.body['id'], @@server1

  end

  def test_h_remove_shared_storage_server

    # Perform Request
    response = @compute.remove_shared_storage_server(shared_storage_id: @@shared_storage_id,
      server_id: @@server1)

    # Assertions
    assert_equal response.body['servers'].length, 0

  end

  def test_i_delete_shared_storage

    # Perform Request
    response = @compute.delete_shared_storage(@@shared_storage_id)

    # Assertions
    assert_equal response.body, 'The requested shared storage has been deleted.'

  end

end