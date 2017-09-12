module Baku
  class EntityManager
    def initialize
      @entities_by_system_mask = {}
      @entities_by_tag = {}
      
      @component_set = Set.new
      @system_mask_cache = {}
    end

    def register_entity(entity)
      entity.tags.each do |tag|
        @entities_by_tag[tag] ||= []
        @entities_by_tag[tag] << entity
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
    
    # TODO: there may be a more efficent way to do this, like by comparing
    # the diff of the mask before and after, but this works for now.
    def entity_add_component(entity, component)
      old_mask = get_component_mask(entity.components)
      entity.components[component.class] = component
      new_mask = get_component_mask(entity.components)

      update_system_membership(entity, old_mask, new_mask)
    end

    def entity_remove_component(entity, component)
      old_mask = get_component_mask(entity.components)
      entity.components.delete(component.class)
      new_mask = get_component_mask(entity.components)

      update_system_membership(entity, old_mask, new_mask)
    end

    def get_entities_for_system(system)
      system_mask = @system_mask_cache[system]
      @entities_by_system_mask[system_mask]
    end

    def get_entities_by_tag(tag)
      @entities_by_tag[tag]
    end

    private

    def get_component_mask(components)
      mask = 0

      @component_set.each_with_index do |c, i|
        mask |= (1 << i) if components.include?(c)
      end

      mask
    end

    def update_system_membership(entity, old_mask, new_mask)
      @entities_by_system_mask.each do |system_mask, entities|
        old_match = (system_mask & old_mask == system_mask)
        new_match = (system_mask & new_mask == system_mask)
        
        if old_match && !new_match
          entities.delete(entity)
        elsif !old_match && new_match
          entities << entity
        end
      end
    end
  end
end
