module Baku
  class EntityManager
    def initialize
      @entities_by_system_mask = {}
      @entities_by_tag = {}
      
      @component_set = Set.new
      @system_mask_cache = {}
    end

    def add_entity(entity)
      entity.tags.each do |tag|
        @entities_by_tag[tag] ||= []
        @entities_by_tag[tag] << entity
      end

      entity.add_event_listener(:component_added, method(:on_entity_component_added))
      entity.add_event_listener(:component_removed, method(:on_entity_component_removed))
    end

    def remove_entity(entity)
      entity.tags.each do |tag|
        @entities_by_tag[tag].delete(entity)
      end

      entity_mask = get_component_mask(entity.components)
      
      @entities_by_system_mask.each do |system_mask, entities|
        if system_mask & entity_mask == system_mask
          entities.delete(entity)
        end
      end
    end
    
    def register_system(system)
      system.components.each do |component|
        @component_set << component
      end

      system_component_mask =
        get_component_mask(system.components)

      @system_mask_cache[system] = system_component_mask
      
      @entities_by_system_mask[system_component_mask] = []
    end        

    def get_entities_by_system(system)
      system_mask = @system_mask_cache[system]
      @entities_by_system_mask[system_mask]
    end

    def get_entities_by_tag(tag)
      @entities_by_tag[tag]
    end

    private

    def get_component_mask(components)
      mask = 0

      @component_set.each_with_index do |component, index|
        mask |= (1 << index) if components.include?(component)
      end

      mask
    end

    def on_entity_component_added(entity, component)
      component_mask = get_component_mask(entity.components)

      @entities_by_system_mask.each do |system_mask, entities|
        if system_mask & component_mask == system_mask
          entities << entity
        end
      end
    end

    def on_entity_component_removed(entity, component)
      # remove from matched
      old_mask = get_component_mask(entity.components + component)
      new_mask = get_component_mask(entity.components)

      @entities_by_system_mask.each do |system_mask, entities|
        old_match = (system_mask & old_mask == system_mask)
        new_match = (system_mask & new_mask == system_mask)
        
        if old_match && !new_match
          entities.delete(entity)
        end
      end      
    end
  end
end
