require_relative '../../lib/fog-oneandone'
require 'minitest/autorun'

Fog.mock!

class TestSshKey < Minitest::Test

  def self.test_order
   :alpha
  end

  def setup

    # Establish Connection
    @compute = Fog::Compute::OneAndOne.new({
      :oneandone_api_key => '<API-TOKEN>'
    })

  end


  def test_a_create_ssh_key

    # Perform Request
    response = @compute.create_ssh_key(name: 'Test SSH Key',
      description: 'Example Desc',
      public_key: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCezYMOgAan+JmatgFJ+Q1FUNjrqNVgAvcTkjYJwHVcQaolq9f9qB7tEeUPDNj2oNN49joAmTcllDcPIxryT5PnQUaaUhu4ZJ9+bRtXCyhnf2LJQdVfzBFEBJX9fW4RiV1XtSAtLRBrbrCb4JjHmhIYpvhBHC29Ve+g64nhdvBhqyLZ3SLI2U/opEmt5u2xftWGl0TBSQYveqc4ntz3fe+f9XlBHvK3Nw12bCLmLle7jQuZ4lXyAYqNAfdOMTs2zMTk422Dl/h4+zRh1h4rM9zaCk4+g3kdugJm7Vul03wm43cHmHsJv51R3XKSHzgb7q/eNj+YdMi5Ndt0Bm+bLjw7')
    
    @@ssh_key_id = response.body['id']

    # Assertions
    assert_equal response.body['name'], 'Test SSH Key'
    assert_equal response.body['description'], 'Example Desc'
    assert_equal response.body['public_key'].end_with?('YdMi5Ndt0Bm+bLjw7') , true

  end

  def test_b_list_ssh_keys
    
    # Perform Request
    response = @compute.list_ssh_keys

    # Assertions
    assert_equal response.body.length>0, true

  end

  def test_c_update_ssh_key

    # Perform Request
    response = @compute.update_ssh_key(ssh_key_id: @@ssh_key_id,
      name: 'New Name', description: 'New Desc')

    # Assertions
    assert_equal response.body['name'], 'New Name'
    assert_equal response.body['description'], 'New Desc'

  end

  def test_d_get_ssh_key

    # Perform Request
    response = @compute.get_ssh_key(@@ssh_key_id)

    # Assertions
    assert_equal response.body['id'], @@ssh_key_id

  end

  def test_i_delete_ssh_key

    # Perform Request
    response = @compute.delete_ssh_key(@@ssh_key_id)

    puts "response.body: #{response.body}"

    # Assertions
    assert_equal response.body, []

  end

end