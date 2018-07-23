require_relative '../lib/fog-oneandone'

compute = Fog::Compute::OneAndOne.new({
  :oneandone_api_key => '<API-TOKEN>'
})

# Create SSH Key
my_ssh_key = compute.ssh_keys.create(name: 'Example App Ssh Key',
                                     description: 'My Fog SSH Key Description',
                                     public_key: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCezYMOgAan+JmatgFJ+Q1FUNjrqNVgAvcTkjYJwHVcQaolq9f9qB7tEeUPDNj2oNN49joAmTcllDcPIxryT5PnQUaaUhu4ZJ9+bRtXCyhnf2LJQdVfzBFEBJX9fW4RiV1XtSAtLRBrbrCb4JjHmhIYpvhBHC29Ve+g64nhdvBhqyLZ3SLI2U/opEmt5u2xftWGl0TBSQYveqc4ntz3fe+f9XlBHvK3Nw12bCLmLle7jQuZ4lXyAYqNAfdOMTs2zMTk422Dl/h4+zRh1h4rM9zaCk4+g3kdugJm7Vul03wm43cHmHsJv51R3XKSHzgb7q/eNj+YdMi5Ndt0Bm+bLjw4')
puts 'Creating ssh key...'

# Create Server
my_server = compute.servers.create(name: 'Example App Server',
  fixed_instance_id: '6E1F2C70CCD3EE44ED194F4FFC47C4C9',
  appliance_id: '8E3BAA98E3DFD37857810E0288DD8FBA',
  datacenter_id: '4EFAD5836CE43ACA502FD5B99BEE44EF',
  public_key: [my_ssh_key.id])

puts 'Creating server...'
puts my_server.wait_for { ready? }


# Create Firewall
puts "----------"
rule1 = {
    'description' => 'Testing firewall improvements fog',
    'protocol' => 'TCP',
    'port' => '90',
    'source' => '0.0.0.0'
}
rule2 = {
    'protocol' => 'TCP',
    'port_from' => 80,
    'port_to' => 80,
    'source' => '0.0.0.0'
}

rules = [rule1, rule2]

my_firewall = compute.firewalls.create(name: 'Example App Firewall',
  rules: rules)
puts 'Creating Firewall...'
puts my_firewall.wait_for { ready? }


# Create Load Balancer
puts "----------"
rule1 = {
  'protocol' => 'TCP',
  'port_balancer' => 80,
  'port_server' => 80,
  'source' => '0.0.0.0'
}

rules = [rule1]

my_load_balancer = compute.load_balancers.create(name: 'Example App LB',
  rules: rules, health_check_test: 'TCP', health_check_interval: 40,
  persistence: true, persistence_time: 1200, method: 'ROUND_ROBIN',
  datacenter_id: '4EFAD5836CE43ACA502FD5B99BEE44EF')
puts 'Creating Load Balancer...'
puts my_load_balancer.wait_for { ready? }


# Add Firewall to Server
puts "----------"
puts 'Adding Firewall to server IP...'
my_server.add_firewall(ip_id: my_server.ips[0]['id'],
  firewall_id: my_firewall.id)
puts my_server.wait_for { ready? }


# Add LB to Server
puts "----------"
puts 'Adding Load Balancer to server IP...'
my_server.add_load_balancer(ip_id: my_server.ips[0]['id'],
  load_balancer_id: my_load_balancer.id)
puts my_server.wait_for { ready? }

# Create Block Storage
my_block_storage = compute.block_storages.create(
  name: 'My Block Storage', size: 20,
  description: 'Testing fog block storage',
  datacenter_id: '4EFAD5836CE43ACA502FD5B99BEE44EF',
  server_id: my_server.id
)
puts 'Creating Block Storage...'
puts my_block_storage.wait_for { ready? }

# Cleanup
puts "----------"
puts 'Destroying server...'
puts my_server.destroy

puts "----------"
puts 'Destroying load balancer...'
puts my_load_balancer.destroy

puts "----------"
puts 'Destroying firewall...'
puts my_firewall.destroy

puts "----------"
puts 'Destroying SSH key...'
puts my_ssh_key.destroy
