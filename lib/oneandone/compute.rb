module Fog
  module Compute
    class OneAndOne < Fog::Service

      # Globals
      SUCCESS_CODES = [200, 201, 202]

      # Required Initialization Parameters
      requires :oneandone_api_key

      # Models
      model_path 'oneandone/models/compute'

      model :server
      collection :servers

      model :image
      collection :images

      model :shared_storage
      collection :shared_storages

      model :firewall
      collection :firewalls

      model :load_balancer
      collection :load_balancers

      model :public_ip
      collection :public_ips

      model :private_network
      collection :private_networks

      model :monitoring_policy
      collection :monitoring_policies

      model :vpn
      collection :vpns

      # Requests
      request_path 'oneandone/requests/compute'

      request :list_servers
      request :get_server
      request :create_server
      request :update_server
      request :delete_server
      
      request :list_fixed_servers
      request :get_fixed_server

      request :get_hardware
      request :update_hardware

      request :get_hdds
      request :add_hdds
      request :get_hdd
      request :update_hdd
      request :delete_hdd

      request :get_server_image
      request :install_server_image

      request :list_server_ips
      request :add_server_ip
      request :get_server_ip
      request :delete_server_ip

      request :list_ip_firewalls
      request :add_firewall
      request :remove_firewall

      request :list_ip_load_balancers
      request :add_load_balancer
      request :remove_load_balancer

      request :status
      request :change_status

      request :get_dvd
      request :eject_dvd
      request :load_dvd

      request :list_server_private_networks
      request :get_server_private_network
      request :remove_private_network
      request :add_private_network

      request :create_snapshot
      request :get_snapshot
      request :restore_snapshot
      request :delete_snapshot

      request :clone_server


      request :list_images
      request :create_image
      request :get_image
      request :update_image
      request :delete_image


      request :list_shared_storages
      request :create_shared_storage
      request :get_shared_storage
      request :update_shared_storage
      request :delete_shared_storage

      request :list_shared_storage_servers
      request :get_shared_storage_server
      request :add_shared_storage_servers
      request :remove_shared_storage_server

      request :access
      request :change_password


      request :list_firewalls
      request :get_firewall
      request :create_firewall
      request :update_firewall
      request :delete_firewall

      request :list_firewall_ips
      request :get_firewall_ip
      request :remove_firewall_ip
      request :add_firewall_ips

      request :list_firewall_rules
      request :get_firewall_rule
      request :add_firewall_rules
      request :delete_firewall_rule


      request :list_load_balancers
      request :create_load_balancer
      request :get_load_balancer
      request :update_load_balancer
      request :delete_load_balancer

      request :list_load_balancer_ips
      request :get_load_balancer_ip
      request :remove_load_balancer_ip
      request :add_load_balancer_ips

      request :list_load_balancer_rules
      request :add_load_balancer_rules
      request :get_load_balancer_rule
      request :delete_load_balancer_rule


      request :list_public_ips
      request :create_public_ip
      request :get_public_ip
      request :update_public_ip
      request :delete_public_ip


      request :list_private_networks
      request :create_private_network
      request :get_private_network
      request :update_private_network
      request :delete_private_network

      request :list_private_network_servers
      request :get_private_network_server
      request :remove_private_network_server
      request :add_private_network_servers


      request :list_monitored_servers
      request :get_monitored_server


      request :list_monitoring_policies
      request :get_monitoring_policy
      request :create_monitoring_policy
      request :update_monitoring_policy
      request :delete_monitoring_policy

      request :list_ports
      request :add_ports
      request :get_port
      request :update_port
      request :delete_port

      request :list_processes
      request :add_processes
      request :get_process
      request :update_process
      request :delete_process

      request :list_mp_servers
      request :get_mp_server
      request :remove_mp_server
      request :add_mp_servers


      request :list_logs
      request :get_log


      request :list_usages


      request :list_server_appliances
      request :get_server_appliance


      request :list_dvds
      request :get_dvd_iso


      request :list_vpns
      request :create_vpn
      request :get_vpn
      request :update_vpn
      request :delete_vpn


      request :ping
      request :ping_auth


      request :list_datacenters
      request :get_datacenter

      class Real
        
        def initialize(options = {})

          @oneandone_api_key = options[:oneandone_api_key]
          @base_url = 'https://cloudpanel-api.1and1.com'
          @version = '/v1'
          @header = {
            'X-TOKEN' => @oneandone_api_key,
            'Content-Type' => 'application/json'
          }
          @connection = Fog::Core::Connection.new(@base_url)

        end

        def request(params)

          # Perform Request
          response = @connection.request(:method => params['method'],
            :path => @version + params['endpoint'],
            :headers => @header,
            :body => params['body'],
            :query => params['params'])

          # Parse body
          response.body = Fog::JSON.decode(response.body)

          # Check for server error
          if response.status == 500
            raise "Internal Server Error.  Please try again."
          end

          # Raise exception if a bad status code is returned
          unless SUCCESS_CODES.include? response.status
            raise response.body
          end

          response

        end

        def clean_hash(hash)

          # Clear Out null Values
          hash.each do |key, value|
            if value == nil
              hash.delete(key)
            end
          end

        end

      end # Real

      class Mock

        def self.data
          
          @data ||= Hash.new do |hash, key|
            hash[key] = {
              :servers  => [],
              :images  => [],
              :shared_storages  => [],
              :firewalls  => [],
              :load_balancers  => [],
              :public_ips  => [],
              :private_networks  => [],
              :monitoring_policies  => [],
              :vpns => [],
              :datacenters => [
                {
                  "id" => "81DEF28500FBC2A973FC0C620DF5B721",
                  "location" => "Spain",
                  "country_code" => "ES"
                },
                {
                  "id" => "908DC2072407C94C8054610AD5A53B8C",
                  "location" => "United States of America",
                  "country_code" => "US"
                },
                {
                  "id" => "4EFAD5836CE43ACA502FD5B99BEE44EF",
                  "location" => "Germany",
                  "country_code" => "DE"
                },
                {
                  "id" => "5091F6D8CBFEF9C26ACE957C652D5D49",
                  "location" => "United Kingdom of Great Britain and Northern Ireland",
                  "country_code" => "GB"
                }
              ],
              :fixed_servers => [
                {
                  "name" => "M",
                  "id" => "8C626C1A7005D0D1F527143C413D461E",
                  "hardware" => {
                    "vcore" => 1,
                    "cores_per_processor" => 1,
                    "ram" => 1,
                    "unit" => "GB",
                    "hdds" => [
                    {
                      "size" => 40,
                      "unit" => "GB",
                      "is_main" => true
                    }
                    ]
                  }
                },
                {
                  "name" => "L",
                  "id" => "8C626C1A7005D0D1F527143C413D461F",
                  "hardware" => {
                    "vcore" => 2,
                    "cores_per_processor" => 1,
                    "ram" => 2,
                    "unit" => "GB",
                    "hdds" => [
                    {
                      "size" => 80,
                      "unit" => "GiB",
                      "is_main" => true
                    }
                    ]
                  }
                },
                {
                  "name" => "XL",
                  "id" => "8C626C1A7005D0D1F527143C413D4620",
                  "hardware" => {
                    "vcore" => 2,
                    "cores_per_processor" => 1,
                    "ram" => 4,
                    "unit" => "GB",
                    "hdds" => [
                    {
                      "size" => 120,
                      "unit" => "GB",
                      "is_main" => true
                    }
                    ]
                  }
                },
                {
                  "name" => "XXL",
                  "id" => "8C626C1A7005D0D1F527143C413D4621",
                  "hardware" => {
                    "vcore" => 4,
                    "cores_per_processor" => 1,
                    "ram" => 8,
                    "unit" => "GB",
                    "hdds" => [
                    {
                      "size" => 160,
                      "unit" => "GiB",
                      "is_main" => true
                    }
                    ]
                  }
                }
              ],
              :logs => [
                {
                  "id" => "E485755233541090E369E957EA2499D7",
                  "start_date" => "2015-04-06T23:46:38Z",
                  "end_date" => "2015-04-06T23:48:52Z",
                  "duration" => 72,
                  "status" => {
                    "state" => "COMPLETED",
                    "percent" => 100
                  },
                  "action" => "DELETE",
                  "type" => "MONITORINGPOLICY",
                  "resource" => {
                    "id" => "E485755233541090E6546957EA2499D7",
                    "name" => "My Monitoring Policy 1"
                  },
                  "details" => {
                    
                  },
                  "user" => {
                    "id" => "7C88E50FBC500A3D9D7F94E414255D6B",
                    "name" => "034b011e.user"
                  },
                  "cloudpanel_id" => "ap99AA4_1"
                },
                {
                  "id" => "E485755233541090E369E957EA2499D8",
                  "start_date" => "2015-04-06T23:51:00Z",
                  "end_date" => "2015-04-06T23:51:29Z",
                  "duration" => 29,
                  "status" => {
                    "state" => "COMPLETED",
                    "percent" => 100
                  },
                  "action" => "CREATE",
                  "type" => "MONITORINGPOLICY",
                  "resource" => {
                    "id" => "E485755233541090E6546957EA2499D7",
                    "name" => "My Monitoring Policy test"
                  },
                  "details" => {
                    
                  },
                  "user" => {
                    "id" => "7C88E50FBC500A3D9D7F94E414255D6B",
                    "name" => "034b011e.user"
                  }
                }
              ],
              :server_appliances => [
                {
                  "id" => "55726DEDA20C99CF6F2AF8F18CAC9963",
                  "name" => "w2012r2datacenter64iso",
                  "available_datacenters" => [
                  "DA41201B4A006EDE6DA62A5A62A658E7",
                  "47FA5A2D251AE57935E30F9D5AB4F817",
                  "7C5FA1D21B98DE39D7516333AAB7DA54"
                  ],
                  "os_installation_base" => "ISO_OS",
                  "os_family" => "Windows",
                  "os" => "WindowsDatacenter",
                  "os_version" => "Windows2012R2",
                  "min_hdd_size" => 40,
                  "os_architecture" => 64,
                  "licenses" => nil,
                  "type" => "ISO",
                  "version" => nil,
                  "categories" => [],
                  "eula_url" => nil
                },
                {
                  "id" => "81504C620D98BCEBAA5202D145203B4C",
                  "name" => "Windows 2008R2 - 64 bits (Standard) + SQL Server 2012 (Standard)",
                  "available_datacenters" => [
                  "DA41201B4A006EDE6DA62A5A62A658E7",
                  "47FA5A2D251AE57935E30F9D5AB4F817",
                  "7C5FA1D21B98DE39D7516333AAB7DA54"
                  ],
                  "os_installation_base" => "Standard",
                  "os_family" => "Windows",
                  "os" => "Windows",
                  "os_version" => "Windows 2008R2",
                  "min_hdd_size" => 40,
                  "os_architecture" => 64,
                  "licenses" =>[
                  "Windows",
                  "SQL Server"
                  ],
                  "type" => "IMAGE", 
                  "version" => nil,
                  "categories" => [],
                  "eula_url" => nil
                }
              ],
              :dvd_isos => [
                {
                  "id" => "55726DEDA20C99CF6F2AF8F18CAC9963",
                  "name" => "w2012r2datacenter64iso",
                  "available_datacenters" => [
                  "DA41201B4A006EDE6DA62A5A62A658E7",
                  "47FA5A2D251AE57935E30F9D5AB4F817",
                  "7C5FA1D21B98DE39D7516333AAB7DA54"
                  ],
                  "os_family" => "Windows",
                  "os" => "WindowsDatacenter",
                  "os_version" => "Windows2012R2",
                  "os_architecture" => 64,
                  "type" => "OS"
                },
                {
                  "id" => "B675B070A3BB5C8D71B2129952F04BC8",
                  "name" => "ubuntu1404-64iso",
                  "available_datacenters" => [
                  "DA41201B4A006EDE6DA62A5A62A658E7",
                  "47FA5A2D251AE57935E30F9D5AB4F817",
                  "7C5FA1D21B98DE39D7516333AAB7DA54"
                  ],
                  "os_family" => "Linux",
                  "os" => "Ubuntu",
                  "os_version" => "Ubuntu14.04",
                  "os_architecture" => 64,
                  "type" => "OS"
                },
                {
                  "id" => "F9DCFAF16B4929D9F9AE6B24B125EC17",
                  "name" => "centos6-32iso",
                  "available_datacenters" => [
                  "DA41201B4A006EDE6DA62A5A62A658E7",
                  "47FA5A2D251AE57935E30F9D5AB4F817",
                  "7C5FA1D21B98DE39D7516333AAB7DA54"
                  ],
                  "os_family" => "Linux",
                  "os" => "Centos",
                  "os_version" => "Centos6",
                  "os_architecture" => 32,
                  "type" => "OS"
                },
                {
                  "id" => "3E04654E0DA19EE6A3699272D4114AFA",
                  "name" => "centos6-64iso",
                  "available_datacenters" => [
                  "DA41201B4A006EDE6DA62A5A62A658E7",
                  "47FA5A2D251AE57935E30F9D5AB4F817",
                  "7C5FA1D21B98DE39D7516333AAB7DA54"
                  ],
                  "os_family" => "Linux",
                  "os" => "Centos",
                  "os_version" => "Centos6",
                  "os_architecture" => 64,
                  "type" => "OS"
                },
                {
                  "id" => "8F8CBE2DAB9FF6F0F9A4D846E82DD651",
                  "name" => "rhel6-64iso",
                  "available_datacenters" => [
                  "DA41201B4A006EDE6DA62A5A62A658E7",
                  "47FA5A2D251AE57935E30F9D5AB4F817",
                  "7C5FA1D21B98DE39D7516333AAB7DA54"
                  ],
                  "os_family" => "Linux",
                  "os" => "RedHat",
                  "os_version" => "RedHat6",
                  "os_architecture" => 64,
                  "type" => "OS"
                },
                {
                  "id" => "B62716F09C314B46D6782EA385E27206",
                  "name" => "centos7-64iso",
                  "available_datacenters" => [
                  "DA41201B4A006EDE6DA62A5A62A658E7",
                  "47FA5A2D251AE57935E30F9D5AB4F817",
                  "7C5FA1D21B98DE39D7516333AAB7DA54"
                  ],
                  "os_family" => "Linux",
                  "os" => "Centos",
                  "os_version" => "Centos7",
                  "os_architecture" => 64,
                  "type" => "OS"
                },
                {
                  "id" => "AE54D0EE48B1F6E59021FAA63988274B",
                  "name" => "debian6-64iso",
                  "available_datacenters" => [
                  "DA41201B4A006EDE6DA62A5A62A658E7",
                  "47FA5A2D251AE57935E30F9D5AB4F817",
                  "7C5FA1D21B98DE39D7516333AAB7DA54"
                  ],
                  "os_family" => "Linux",
                  "os" => "Debian",
                  "os_version" => "Debian6",
                  "os_architecture" => 64,
                  "type" => "OS"
                },
                {
                  "id" => "AA70C76B77BC6132117DCA202D34A5A4",
                  "name" => "debian6-32iso",
                  "available_datacenters" => [
                  "DA41201B4A006EDE6DA62A5A62A658E7",
                  "47FA5A2D251AE57935E30F9D5AB4F817",
                  "7C5FA1D21B98DE39D7516333AAB7DA54"
                  ],
                  "os_family" => "Linux",
                  "os" => "Debian",
                  "os_version" => "Debian6",
                  "os_architecture" => 32,
                  "type" => "OS"
                },
                {
                  "id" => "4001EE28F2E195BD4D2D44844FAC9591",
                  "name" => "debian7-64iso",
                  "available_datacenters" => [
                  "DA41201B4A006EDE6DA62A5A62A658E7",
                  "47FA5A2D251AE57935E30F9D5AB4F817",
                  "7C5FA1D21B98DE39D7516333AAB7DA54"
                  ],
                  "os_family" => "Linux",
                  "os" => "Debian",
                  "os_version" => "Debian7",
                  "os_architecture" => 64,
                  "type" => "OS"
                },
                {
                  "id" => "B1A2D93BE081873BF127C9B9200849D8",
                  "name" => "debian7-32iso",
                  "available_datacenters" => [
                  "DA41201B4A006EDE6DA62A5A62A658E7",
                  "47FA5A2D251AE57935E30F9D5AB4F817",
                  "7C5FA1D21B98DE39D7516333AAB7DA54"
                  ],
                  "os_family" => "Linux",
                  "os" => "Debian",
                  "os_version" => "Debian7",
                  "os_architecture" => 32,
                  "type" => "OS"
                },
                {
                  "id" => "DC0886301FA0BFDD8BA21F3E9FDFC012",
                  "name" => "freebsd10-64iso",
                  "available_datacenters" => [
                  "DA41201B4A006EDE6DA62A5A62A658E7",
                  "47FA5A2D251AE57935E30F9D5AB4F817",
                  "7C5FA1D21B98DE39D7516333AAB7DA54"
                  ],
                  "os_family" => "Linux",
                  "os" => "FreeBSD",
                  "os_version" => "FreeBSD10",
                  "os_architecture" => 64,
                  "type" => "OS"
                },
                {
                  "id" => "369A148192AAD04C83FEC050F9072C76",
                  "name" => "freebsd10-32iso",
                  "available_datacenters" => [
                  "DA41201B4A006EDE6DA62A5A62A658E7",
                  "47FA5A2D251AE57935E30F9D5AB4F817",
                  "7C5FA1D21B98DE39D7516333AAB7DA54"
                  ],
                  "os_family" => "Linux",
                  "os" => "FreeBSD",
                  "os_version" => "FreeBSD10",
                  "os_architecture" => 32,
                  "type" => "OS"
                },
                {
                  "id" => "9F3A97E35D7C182EE7B871B7FBFEBBDC",
                  "name" => "rhel7-64iso",
                  "available_datacenters" => [
                  "DA41201B4A006EDE6DA62A5A62A658E7",
                  "47FA5A2D251AE57935E30F9D5AB4F817",
                  "7C5FA1D21B98DE39D7516333AAB7DA54"
                  ],
                  "os_family" => "Linux",
                  "os" => "RedHat",
                  "os_version" => "RedHat7",
                  "os_architecture" => 64,
                  "type" => "OS"
                },
                {
                  "id" => "FEF6DB2420612426911F2F9CA9E25755",
                  "name" => "w2008r2datacenter64iso",
                  "available_datacenters" => [
                  "DA41201B4A006EDE6DA62A5A62A658E7",
                  "47FA5A2D251AE57935E30F9D5AB4F817",
                  "7C5FA1D21B98DE39D7516333AAB7DA54"
                  ],
                  "os_family" => "Windows",
                  "os" => "WindowsDatacenter",
                  "os_version" => "Windows2008R2",
                  "os_architecture" => 64,
                  "type" => "OS"
                }
              ]
            }
          end

        end


        def initialize(options={})
          
          @oneandone_api_key = options[:oneandone_api_key]

        end


        def data

          self.class.data[@oneandone_api_key]

        end


        def reset_data

          self.class.data.delete(@oneandone_api_key)

        end

      end # Mock

    end # OneAndOne
  end # Compute
end # Fog