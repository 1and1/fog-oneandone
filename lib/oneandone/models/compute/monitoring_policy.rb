module Fog
  module Compute
    class OneAndOne
      class MonitoringPolicy < Fog::Model

        # Declare Model Attributes
        identity  :id

        attribute :name
        attribute :description
        attribute :email
        attribute :agent
        attribute :thresholds
        attribute :ports
        attribute :processes
        
        attribute :state
        attribute :creation_date
        attribute :servers
        
        
        def save

          requires :name, :agent, :email, :thresholds, :ports, :processes

          # Perform Request
          response = service.create_monitoring_policy(name: name,
            description: description, email: email, agent: agent,
            thresholds: thresholds, ports: ports, processes: processes)

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def update(options = {})

          requires :id

          response = service.update_monitoring_policy(monitoring_policy_id: id,
            name: options[:name], description: options[:description],
            email: options[:email], thresholds: options[:thresholds])

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def add_ports(options = {})

          requires :id

          response = service.add_ports(monitoring_policy_id: id,
            ports: options[:ports])

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def delete_port(options = {})

          requires :id

          response = service.delete_port(monitoring_policy_id: id,
            port_id: options[:port_id])

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def update_port(options = {})

          requires :id

          response = service.update_port(monitoring_policy_id: id,
            port_id: options[:port_id], new_port: options[:new_port])

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def add_processes(options = {})

          requires :id

          response = service.add_processes(monitoring_policy_id: id,
            processes: options[:processes])

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def delete_process(options = {})

          requires :id

          response = service.delete_process(monitoring_policy_id: id,
            process_id: options[:process_id])

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def update_process(options = {})

          requires :id

          response = service.update_process(monitoring_policy_id: id,
            process_id: options[:process_id],
            new_process: options[:new_process])

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def add_servers(options = {})

          requires :id

          response = service.add_mp_servers(monitoring_policy_id: id,
            servers: options[:servers])

          # Decode and Merge Attributes
          merge_attributes(response.body)

          true

        end


        def remove_server(options = {})

          requires :id

          response = service.remove_mp_server(monitoring_policy_id: id,
            server_id: options[:server_id])

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def destroy

          requires :id

          service.delete_monitoring_policy(id)
          
          true

        end


        def ready?

          state == 'ACTIVE'

        end

      end # MonitoringPolicy
    end # OneAndOne
  end # Compute
end # Fog