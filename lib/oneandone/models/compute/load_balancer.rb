module Fog
  module Compute
    class OneAndOne
      class LoadBalancer < Fog::Model

        # Declare Model Attributes
        identity  :id

        attribute :name
        attribute :description
        attribute :state
        attribute :rules
        attribute :datacenter
        attribute :datacenter_id
        attribute :health_check_test
        attribute :health_check_interval
        attribute :persistence
        attribute :persistence_time
        attribute :method
        attribute :health_check_path
        attribute :health_check_parse
        attribute :creation_date
        attribute :server_ips
        
        
        def save

          requires :name, :rules, :health_check_test, :health_check_interval,
            :persistence, :persistence_time, :method

          # Perform Request
          response = service.create_load_balancer(name: name,
            description: description, health_check_test: health_check_test,
            health_check_interval: health_check_interval,
            persistence: persistence, persistence_time: persistence_time,
            method: method, rules: rules, health_check_path: health_check_path,
            health_check_parse: health_check_parse, datacenter_id: datacenter_id)

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def update(options = {})

          requires :id

          response = service.update_load_balancer(load_balancer_id: id,
            name: options[:name], description: options[:description],
            health_check_test: options[:health_check_test],
            health_check_interval: options[:health_check_interval],
            persistence: options[:persistence],
            persistence_time: options[:persistence_time],
            method: options[:method],
            health_check_path: options[:health_check_path],
            health_check_parse: options[:health_check_parse])

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def add_ips(options = {})

          requires :id

          response = service.add_load_balancer_ips(load_balancer_id: id,
            ips: options[:ips])

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def remove_ip(options = {})

          requires :id

          response = service.remove_load_balancer_ip(load_balancer_id: id,
            ip_id: options[:ip_id])

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def add_rules(options = {})

          requires :id

          response = service.add_load_balancer_rules(load_balancer_id: id,
            rules: options[:rules])

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def delete_rule(options = {})

          requires :id

          response = service.delete_load_balancer_rule(load_balancer_id: id,
            rule_id: options[:rule_id])

          # Merge Attributes
          merge_attributes(response.body)

          true

        end


        def destroy

          requires :id

          service.delete_load_balancer(id)
          
          true

        end


        def ready?

          state == 'ACTIVE'

        end

      end # LoadBalancer
    end # OneAndOne
  end # Compute
end # Fog