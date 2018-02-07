# Fog-oneandone

[![Build Status](https://travis-ci.org/tjb1019/fog.svg?branch=master)](https://travis-ci.org/tjb1019/fog)

Fog is an open-source, community Ruby library used for interacting with popular cloud infrastructure providers through a single, unified API. For more information on the Fog plug-in see the [1&1 Community Portal](https://www.1and1.com/cloud-community/).

This guide will show you how to programmatically use the 1&amp;1 provider in Fog to perform common management tasks available in the 1&amp;1 Cloud Panel.

## Table of Contents

- [Overview](#overview)
- [Getting Started](#getting-started)
  * [Installation](#installation)
  * [Authentication](#authentication)
- [Models](#models)
  - [Creating a Server](#creating-a-server)
  - [Updating Server Cores, Memory, and Disk](#updating-server-cores-memory-and-disk)
  - [Deleting a Server](#deleting-a-server)
- [Collections](#collections)
- [Mocks](#mocks)
- [Example App](#example-app)



## Overview

The Fog library wraps the <a href='https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html'>1&amp;1 REST API</a>. All API operations are performed over SSL and authenticated using your 1&amp;1 credentials. The API can be accessed within an instance running in 1&amp;1 or directly over the Internet from any application that can send an HTTPS request and receive an HTTPS response.

The Fog library provides two methods of interacting with 1&amp;1. The first method utilizes an abstracted collection and model layer that is similar across all cloud providers within Fog.

A collection is a group of similar resources such as servers, images, or firewalls and allows basic CRUD (create/read/update/delete) operations on collections and models. This guide will cover interactions with the 1&amp;1 environment solely using collections and models.

While out of scope of this guide, the second Fog method provides direct request methods that specifically match provider API methods. In the case of the 1&amp;1 provider, the request methods map to the <a href='https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html'>1&amp;1 REST API</a> endpoints and parameters. More details on requests can be found at the <a href='http://fog.io'>Fog</a> website.


## Getting Started

Before you begin you will need to have signed-up for a 1&amp;1 account. The credentials you setup during sign-up will be used to authenticate against the API.


### Installation

You can install the latest stable version using:

`$ gem install fog-oneandone`


### Authentication

Connecting to 1&amp;1 can be done by creating a compute connection with the provider.

```ruby
require 'fog-oneandone'

compute = Fog::Compute::OneAndOne.new({
  :oneandone_api_key => '<API-TOKEN>'
})
```

Credentials can be specified as shown above or placed in a `.fog` file located in the home directory.

```bash
$ less ~/.fog
default:
  oneandone_api_key: <API-TOKEN>
```


## Models

Models act as your interface for working with provider resources.  In the examples below, we will create a server, and perform various actions to that server using its model.  All models come equipped with the `wait_for` and `destroy` methods, as well as other methods that perform various `POST`, `PUT`, and `DELETE` actions.  These additional methods vary by model. 


### Creating a Server

The following example shows you how to create a new server in the Great Britain 
data center with a fixed hardware configuration.

The server can take time to provision. The `wait_for` server object method will wait until the server state is available before continuing, and returns a hash containing the method's execution duration. This is useful when chaining together requests that are dependent upon one another.

A server "model" will be returned to the `my_server` variable.  You can use this model to access the server's attributes and perform further operations.
```ruby
compute = Fog::Compute::OneAndOne.new({
  :oneandone_api_key => '<API-TOKEN>'
})


my_server = compute.servers.create(name: 'My Server',
  fixed_instance_id: '65929629F35BBFBA63022008F773F3EB',
  appliance_id: '6C902E5899CC6F7ED18595EBEB542EE1',
  datacenter_id: '5091F6D8CBFEF9C26ACE957C652D5D49')

puts my_server.wait_for { ready? }
```

If you would prefer to set your own custom hardware configuration, then simply replace `fixed_instance_id` with values for
`vcore`, `ram`, `cores_per_processor`, and `hdds`, like so:

```ruby
hdd1 = {
  'is_main' => true,
  'size' => 60
}

hdds = [hdd1]

my_server = compute.servers.create(name: 'My Server',
  vcore: 1, ram: 1, cores_per_processor: 1, hdds: hdds
  appliance_id: '6C902E5899CC6F7ED18595EBEB542EE1',
  datacenter_id: '5091F6D8CBFEF9C26ACE957C652D5D49')
  
 puts my_server.wait_for { ready? }
```

### Updating Server Cores, Memory, and Disk

Using our `my_server` model from above, we can easily update the server's hardware configuration, like so:

```ruby
my_server.update_hardware(vcore: 2, ram: 4)
my_server.wait_for { ready? }

puts my_server.hardware['vcore'] 
>> 2

puts my_server.hardware['ram']
>> 4
```

Need extra storage?  Adding an additional HDD is easy:

```ruby
hdd2 = {
 'is_main' => false,
 'size' => 80
}

hdds = [hdd2]

my_server.add_hdds(hdds: hdds)
my_server.wait_for { ready? }

puts my_server.hardware['hdds']
>> [{'is_main' => true, 'size' => 60}, {'is_main' => false, 'size' => 80}]
```

Ready to downsize?  Deleting storage is easy too:

```ruby
hdd2_id = my_server.hardware['hdds'][1]['id']

my_server.delete_hdd(hdd_id: hdd2_id)
my_server.wait_for { ready? }

puts my_server.hardware['hdds']
>> [{'is_main' => true, 'size' => 60}]
```


### Deleting a Server

When you are finished with your server, use the `destroy` method to permanently delete the resource from the provider.  The `destroy` method is available on all models.

```ruby
puts my_server.destroy
>> true
```


## Collections

A high level interface to each cloud is provided through collections, such as `images` and `servers`. You can see a list of available collections by calling `collections` on the connection object.

```ruby
compute = Fog::Compute::OneAndOne.new({
  :oneandone_api_key => '<API-TOKEN>'
})

puts compute.collections
>>
servers
images
shared_storages
firewalls
load_balancers
public_ips
private_networks
monitoring_policies
vpns
block_storages
ssh_keys
```

Each collection comes equipped with the `create`, `all`, and `get` methods.  You've seen how the `create` method works in our server example above.  `all` will fetch every object of that type from the provider, and generate a model for each of those objects.  Here's an example:

```ruby
servers = compute.servers.all
first_server = servers[0]

puts first_server.name
>> Test Server

puts first_server.status['state']
>> POWERED_ON

puts first_server.destroy
>> true
```

`get` will fetch a single object from the provider and generate a model for the specified object.

```ruby
bad_server = compute.servers.get('<BAD-SERVER-ID>')

puts bad_server.destroy
>> true
```


## Mocks

As you might imagine, testing code using Fog can be slow and expensive, constantly turning on and shutting down instances. Mocking allows skipping this overhead by providing an in memory representation of resources as you make requests. Enabling mocking is easy to use: before you run other commands, simply run:

```ruby
Fog.mock!
```

Then, proceed as usual. If you run into unimplemented mocks, fog will raise an error.



## Example App

This simple app creates a load balancer, firewall policy, and server. It then adds the load balancer and firewall policy to the server's initial IP address. You can access a server's initial IP by using the `ips` attribute on the server model, as seen in the example below.

The source code for the Example App can be found <a href='examples/example_app.rb'>here</a>.

```ruby
require 'fog-oneandone'

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
```
