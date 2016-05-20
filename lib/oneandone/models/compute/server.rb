module Fog
  module Compute
    class OneAndOne
      class Server < Fog::Model

        # Globals
        GOOD_STATES = ['POWERED_ON', 'POWERED_OFF']

        # Declare Model Attributes
        identity  :id

        attribute :name
        attribute :description
        attribute :rsa_key
        attribute :fixed_instance_id
        attribute :ram
        attribute :vcore
        attribute :cores_per_processor
        attribute :hdds
        attribute :datacenter
        attribute :datacenter_id
        attribute :creation_date
        attribute :first_password
        attribute :status
        attribute :hardware
        attribute :image
        attribute :appliance_id
        attribute :password
        attribute :power_on
        attribute :firewall_id
        attribute :ip_id
        attribute :load_balancer_id
        attribute :monitoring_policy_id
        attribute :dvd
        attribute :snapshot
        attribute :ips
        attribute :alerts
        attribute :monitoring_policy
        attribute :private_networks

        
        def save

          requires :name, :appliance_id

          # Check for Additional Required Parameters
          if (!fixed_instance_id)
            requires :ram, :vcore, :cores_per_processor, :hdds
          end

          # Perform Request
          response = service.create_server(name: name, description: description,
            rsa_key: rsa_key, fixed_instance_id: fixed_instance_id,
            vcore: vcore, cores_per_processor: cores_per_processor, ram: ram,
            appliance_id: appliance_id, hdds: hdds, datacenter_id: datacenter_id,
            password: password, power_on: power_on, firewall_id: firewall_id,
            ip_id: ip_id, load_balancer_id: load_balancer_id,
            monitoring_policy_id: monitoring_policy_id)

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def update(options = {})

          requires :id

          response = service.update_server(server_id: id, name: options[:name],
            description: options[:description])

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def update_hardware(options = {})

          requires :id

          response = service.update_hardware(server_id: id,
            fixed_instance_id: options[:fixed_instance_id],
            vcore: options[:vcore], ram: options[:ram],
            cores_per_processor: options[:cores_per_processor])

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def add_hdds(options = {})

          requires :id

          response = service.add_hdds(server_id: id,
            hdds: options[:hdds])

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def delete_hdd(options = {})

          requires :id

          response = service.delete_hdd(server_id: id,
            hdd_id: options[:hdd_id])

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def resize_hdd(options = {})

          requires :id

          response = service.update_hdd(server_id: id,
            hdd_id: options[:hdd_id], size: options[:size])

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def install_image(options = {})

          requires :id

          response = service.install_server_image(server_id: id,
            image_id: options[:image_id], password: options[:password],
            firewall_id: options[:firewall_id])

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def add_ip

          requires :id

          response = service.add_server_ip(server_id: id)

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def delete_ip(options = {})

          requires :id

          response = service.delete_server_ip(server_id: id,
            ip_id: options[:ip_id])

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def add_firewall(options = {})

          requires :id

          response = service.add_firewall(server_id: id,
            ip_id: options[:ip_id], firewall_id: options[:firewall_id])

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def remove_firewall(options = {})

          requires :id

          response = service.remove_firewall(server_id: id,
            ip_id: options[:ip_id])

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def add_load_balancer(options = {})

          requires :id

          response = service.add_load_balancer(server_id: id,
            ip_id: options[:ip_id],
            load_balancer_id: options[:load_balancer_id])

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def remove_load_balancer(options = {})

          requires :id

          response = service.remove_load_balancer(server_id: id,
            ip_id: options[:ip_id],
            load_balancer_id: options[:load_balancer_id])

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def on

          requires :id

          response = service.change_status(server_id: id,
            action: 'POWER_ON', method: 'SOFTWARE')

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def off

          requires :id

          response = service.change_status(server_id: id,
            action: 'POWER_OFF', method: 'SOFTWARE')

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def reboot

          requires :id

          response = service.change_status(server_id: id,
            action: 'REBOOT', method: 'SOFTWARE')

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def load_dvd(options = {})

          requires :id

          response = service.load_dvd(server_id: id, dvd_id: options[:dvd_id])

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def eject_dvd

          requires :id

          response = service.eject_dvd(server_id: id)

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def add_private_network(options = {})

          requires :id

          response = service.add_private_network(server_id: id,
            private_network_id: options[:private_network_id])

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def remove_private_network(options = {})

          requires :id

          response = service.remove_private_network(server_id: id,
            private_network_id: options[:private_network_id])

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def create_snapshot

          requires :id

          response = service.create_snapshot(server_id: id)

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def restore_snapshot(options = {})

          requires :id

          response = service.restore_snapshot(server_id: id,
            snapshot_id: options[:snapshot_id])

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def delete_snapshot(options = {})

          requires :id

          response = service.delete_snapshot(server_id: id,
            snapshot_id: options[:snapshot_id])

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def clone(options = {})

          requires :id

          response = service.clone_server(server_id: id, name: options[:name],
            datacenter_id: options[:datacenter_id])

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def destroy

          requires :id

          service.delete_server(id)
          
          true

        end


        def ready?

          (GOOD_STATES.include? status['state']) && (status['percent'] == nil)

        end

      end # Server
    end # OneAndOne
  end # Compute
end # Fog