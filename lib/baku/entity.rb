module Baku
  class Entity
    include Baku::EventDispatcher
    
    attr_reader :components, :tags
    
    def initialize(tags = [])
      @tags = tags
      @components = {}
    end

    def add_component(component)
      if @components.has_key?(component.class)
        raise StandardError.
          new("Entity already has component: #{component.class}")
      end

      components[component.class] = component

      dispatch_event(:component_added, self, component)
    end

    def remove_component(component_class)
      if !@components.has_key?(component_class)
        raise StandardError.
          new("Entity does not have component: #{component_class}")
      end

      @components.delete(component_class)

      dispatch_event(:component_removed, self, @components[component_class])
    end
    
    def get_component(component_class)
      @components[component_class]
    end
  end
end
