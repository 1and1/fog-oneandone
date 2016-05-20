require_relative '../../lib/fog-oneandone'
require 'minitest/autorun'

Fog.mock!

class TestImage < Minitest::Test
  
  def self.test_order
   :alpha
  end

  def setup

    # Establish Connection
    @compute = Fog::Compute::OneAndOne.new({
      :oneandone_api_key => 'APIKEY'
    })

  end


  def test_a_create_image

    # Perform Request
    response = @compute.create_image(server_id: 'ServerID',
      name: 'Test Image', frequency: 'ONCE', num_images: 1)
    
    @@image_id = response.body['id']

    # Assertions
    assert_equal response.body['name'], 'Test Image'
    assert_equal response.body['frequency'], 'ONCE'
    assert_equal response.body['num_images'], 1

  end

  def test_b_list_images
    
    # Perform Request
    response = @compute.list_images

    # Assertions
    assert_equal response.body.length, 1

  end

  def test_c_update_image

    # Perform Request
    response = @compute.update_image(image_id: @@image_id,
      name: 'New Name', frequency: 'WEEKLY')

    # Assertions
    assert_equal response.body['name'], 'New Name'
    assert_equal response.body['frequency'], 'WEEKLY'

  end

  def test_d_get_image

    # Perform Request
    response = @compute.get_image(@@image_id)

    # Assertions
    assert_equal response.body['id'], @@image_id

  end

  def test_e_delete_image

    # Perform Request
    response = @compute.delete_image(@@image_id)

    # Assertions
    assert_equal response.body, 'The requested image has been deleted.'

  end

end