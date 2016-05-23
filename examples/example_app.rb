require_relative '../lib/fog-oneandone'

compute = Fog::Compute::OneAndOne.new({
  :oneandone_api_key => '<API-TOKEN>'
})

# Create Server
my_server = compute.servers.create(name: 'Example App Server',
  fixed_instance_id: '65929629F35BBFBA63022008F773F3EB',
  appliance_id: '6C902E5899CC6F7ED18595EBEB542EE1',
  datacenter_id: '5091F6D8CBFEF9C26ACE957C652D5D49')

puts 'Creating server...'
puts my_server.wait_for { ready? }


# Create Firewall
puts "----------"
rule1 = {
  'protocol' => 'TCP',
  'port_from' => 80,
  'port_to' => 80,
  'source' => '0.0.0.0'
}

rules = [rule1]

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
  datacenter_id: '5091F6D8CBFEF9C26ACE957C652D5D49')
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
