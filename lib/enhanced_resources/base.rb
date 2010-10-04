module EnhancedResources
  class Base < ::ApplicationController
    def self.enhanced_resources(base, options={})
      base.class_eval do
        inherit_resources
        respond_to :html, :xml, :json

        include EnhancedResources::BaseHelpers
        extend  EnhancedResources::ClassMethods
       
        defaults_options = {}
        defaults_options[:resource_class] = options.delete(:class) if options.has_key?(:class)
        defaults_options[:instance_name] = options.delete(:instance_name) if options.has_key?(:instance_name)
        defaults_options[:collection_name] = options.delete(:collection_name) if options.has_key?(:collection_name)
        defaults_options[:route_prefix] = options.delete(:route_prefix) if options.has_key?(:route_prefix)

        if defaults_options.any?
          defaults defaults_options
        end

        base.with_options :instance_writer => false do |c|
          c.class_inheritable_accessor :authenticated_user_references
          c.class_inheritable_accessor :parameter_nestings
          c.class_inheritable_accessor :references
        end

        self.authenticated_user_references = []
        self.parameter_nestings = []
        self.references = []
      end
    end
  end
end
