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

      update_component_mask
      
      dispatch_event(:component_added, self, component)
    end

    def remove_component(component_class)
      if !@components.has_key?(component_class)
        raise StandardError.
          new("Entity does not have component: #{component_class}")
      end

      removed_component = @components[component_class]
      @components.delete(component_class)

      update_component_mask
      
      dispatch_event(:component_removed, self, removed_component)
    end

    def has_component?(component_class)
      @components.has_key?(component_class)
    end
    
    def get_component(component_class)
      @components[component_class]
    end

    def component_mask
      @component_mask ||= ComponentMask.from_components(@components)
    end

    private

    def update_component_mask
      @component_mask = ComponentMask.from_components(@components)
    end
  end
end
