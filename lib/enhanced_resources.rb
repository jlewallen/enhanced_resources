module EnhancedResources
  autoload :Base,         'enhanced_resources/base'
  autoload :BaseHelpers,  'enhanced_resources/base_helpers'
  autoload :ClassMethods, 'enhanced_resources/class_methods'
end

class ActionController::Base
  def self.enhanced_resources(options={})
    ::EnhancedResources::Base.enhanced_resources(self, options)
  end
end
