module EnhancedResources
  module ClassMethods
    def reference_authenticated_user(attribute)
      self.authenticated_user_references << attribute
    end
    
    def reference(*symbols)
      options = symbols.extract_options!
      options.symbolize_keys!
      self.references << { :attribute => symbols.first, :param_id => symbols.last }.merge(options)
    end

    def nested(*symbols)
      self.parameter_nestings << symbols
      self.parameter_nestings.flatten!
    end

    def default_attribute(*args)
      options = args.extract_options!
      options.symbolize_keys!
      self.default_attributes << { :attribute => args[0], :factory => args[1], :options => options }
    end

    def back_to_referrer(methods=[:destroy, :update])
      methods.each do |method|
        self.class_eval <<-END
          def #{method}
            super do |success, failure|
              success.html { redirect_to :back }
            end
          end
        END
      end
    end
  end
end
