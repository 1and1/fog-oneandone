module Fog
  module Compute
    class OneAndOne

      class Real

        ##
        # Creates a new server
        # URL: [https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html#servers_post]
        ##
        def create_server(name: nil, description: nil, rsa_key: nil,
          fixed_instance_id: nil, vcore: nil, cores_per_processor: nil,
          ram: nil, appliance_id: nil, datacenter_id: nil, hdds: nil,
          password: nil, power_on: nil, firewall_id: nil, ip_id: nil,
          load_balancer_id: nil, monitoring_policy_id: nil, public_key: nil)
          
          # Build hardware hash
          hardware_params = {
            'fixed_instance_size_id' => fixed_instance_id,
            'vcore' => vcore,
            'cores_per_processor' => cores_per_processor,
            'ram' => ram,
            'hdds' => hdds
          }

          # Clean out null values from hardware hash
          hardware = clean_hash(hardware_params)

          # Build POST body
          new_server = {
            'name' => name,
            'description' => description,
            'rsa_key' => rsa_key,
            'hardware' => hardware,
            'appliance_id' => appliance_id,
            'datacenter_id' => datacenter_id,
            'password' => password,
            'power_on' => power_on,
            'firewall_policy_id' => firewall_id,
            'ip_id' => ip_id,
            'load_balancer_id' => load_balancer_id,
            'monitoring_policy_id' => monitoring_policy_id,
            'public_key' => public_key
          }

          # Clean out null values from POST body
          body = clean_hash(new_server)

          # Stringify the POST body
          string_body = Fog::JSON.encode(body)

          # Request
          params = {
            'method' => :post,
            'endpoint' => '/servers',
            'body' => string_body
          }

          request(params)

        end

      end # Real

      
      class Mock

        def create_server(name: nil, description: nil, rsa_key: nil,
          fixed_instance_id: nil, vcore: nil, cores_per_processor: nil,
          ram: nil, appliance_id: nil, datacenter_id: nil, hdds: nil,
          password: nil, power_on: nil, firewall_id: nil, ip_id: nil,
          load_balancer_id: nil, monitoring_policy_id: nil, public_key: nil)
          
          # Add UUID to hdds being passed in
          if hdds
            hdds.each do |hdd|
              hdd['id'] = Fog::UUID.uuid
            end
          end

          # Create mock server hash
          mock_server = {
            "id" => Fog::UUID.uuid,
            "cloudpanel_id" => "FE7ED7D",
            "name" => name,
            "description" => description,
            "datacenter" => {
              "id" => datacenter_id,
              "location" => "USA",
              "country_code" => "US"
            },
            "creation_date" => "2015-05-07T08:25:37+00:00",
            "first_password" => "Nm4gP97xSw",
            "status" => {
              "state" => "POWERED_ON",
              "percent" => nil
            },
            "hardware" => {
              "fixed_instance_size_id" => fixed_instance_id,
              "vcore" => vcore,
              "cores_per_processor" => cores_per_processor,
              "ram" => ram,
              "hdds" => hdds
            },
            "image" => {
              "id" => appliance_id,
              "name" => nil
            },
            "dvd" => nil,
            "snapshot" => {},
            "ips" => [
              {
                'id' => Fog::UUID.uuid,
                'type' => 'IPV4',
                'firewall_policy' => {},
                'load_balancers' => []
              }
            ],
            "alerts" => [],
            "monitoring_policy" => nil,
            "private_networks" => []
          }

          # Save mock server to servers list
          self.data[:servers] << mock_server

          # Return mock response to user
          response = Excon::Response.new
          response.status = 202
          response.body = mock_server
            
          response

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog