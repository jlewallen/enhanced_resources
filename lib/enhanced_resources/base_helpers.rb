module EnhancedResources
  module BaseHelpers
    protected
      def build_resource
        parameter_nestings.each do |id|
          if params.has_key?(id)
            params[resource_instance_name] ||= {}
            params[resource_instance_name][id] = params[id]
          end
        end
        get_resource_ivar || set_resource_ivar(fresh_resource(end_of_association_chain.send(method_for_build, params[resource_instance_name] || {})))
      end

      def resource
        target = end_of_association_chain
        method = :find
	      method = :get if target.respond_to?(:get)
        get_resource_ivar || set_resource_ivar(target.send(method, params[:id]))
      end

      def fresh_resource(instance)
        return instance if instance.persisted?

        authenticated_user_references.each do |attribute|
          instance.send("#{attribute}=", current_user)
        end

        default_attributes.each do |builder|
          attribute = builder[:attribute]
          value = builder[:factory].call(current_user)
          instance.send("#{attribute}=", value)
        end

        references.each do |builder|
          attribute = builder[:attribute]
          param_id = builder[:param_id]
          klass = begin
            if builder.has_key?(:class)
              builder[:class]
            else
              attribute.to_s.capitalize.constantize
            end
          end
          if params.has_key?(param_id)
            instance.send("#{attribute}=", klass.find(params[param_id]))
          end
        end
        instance
      end
  end
end
