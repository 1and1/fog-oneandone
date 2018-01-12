require_relative '../../lib/fog-oneandone'
require 'minitest/autorun'

Fog.mock!

class TestBlockStorage < Minitest::Test

  def self.test_order
   :alpha
  end

  def setup

    # Establish Connection
    @compute = Fog::Compute::OneAndOne.new({
      :oneandone_api_key => '<API-TOKEN>'
    })

  end


  def test_a_create_block_storage

    # Perform Request
    response = @compute.create_block_storage(name: 'Test Block Storage',
      description: 'Example Desc', size: 20,
      datacenter_id: '4EFAD5836CE43ACA502FD5B99BEE44EF')
    
    @@block_storage_id = response.body['id']

    # Assertions
    assert_equal response.body['name'], 'Test Block Storage'
    assert_equal response.body['description'], 'Example Desc'
    assert_equal response.body['size'], 20

  end

  def test_b_list_block_storages
    
    # Perform Request
    response = @compute.list_block_storages

    # Assertions
    assert_equal response.body.length, 1

  end

  def test_c_update_block_storage

    # Perform Request
    response = @compute.update_block_storage(block_storage_id: @@block_storage_id,
      name: 'New Name', description: 'New Desc')

    # Assertions
    assert_equal response.body['name'], 'New Name'
    assert_equal response.body['description'], 'New Desc'

  end

  def test_d_get_block_storage

    # Perform Request
    response = @compute.get_block_storage(@@block_storage_id)

    # Assertions
    assert_equal response.body['id'], @@block_storage_id

  end

  def test_i_delete_block_storage

    # Perform Request
    response = @compute.delete_block_storage(@@block_storage_id)

    puts "response.body: #{response.body}"

    # Assertions
    assert_equal response.body, []

  end

end