module Baku
  class Entity
    attr_reader :id, :components, :tags
    
    def initialize(world, tags = [])
      @world = world
      @tags = tags
      
      @id = SecureRandom.uuid
      @components = {}
    end

    def add_component(component)
      if @components.has_key?(component.class)
        raise StandardError.
          new("Entity already has component: #{component.class}")
      end

      # TODO: this is some pretty ugly coupling, figure out if there's a cleaner
      # way to do this. Callbacks or something.
      @world.entity_manager.entity_add_component(self, component)
    end

    def remove_component(component)
      if !@components.has_key?(component.class)
        raise StandardError.
          new("Entity does not have component: #{component.class}")
      end

      # TODO: this is some pretty ugly coupling, figure out if there's a cleaner
      # way to do this. Callbacks or something.
      @world.entity_manager.entity_remove_component(self, component)
    end
    
    def get_component(component_class)
      @components[component_class]
    end
  end
end
