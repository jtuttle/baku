module Baku
  # The EntityManager stores entities in such a way that they can be retrieved
  # efficiently by either ComponentMask or tag. Before storing any entities, the
  # ComponentMasks that we wish to match on should be registered. This step is
  # performed transparently by the World whenever a System is added.
  class EntityManager
    def initialize
      @entities_by_component_mask = {}
      @entities_by_tag = {}
    end

    def dispose
      @entities_by_component_mask.clear
      @entities_by_tag.clear
    end

    def register_component_mask(component_mask)
      @entities_by_component_mask[component_mask] = []
    end

    def add_entity(entity)
      add_entity_to_matching_component_lists(entity)
      
      entity.add_event_listener(:component_added,
                                method(:on_entity_component_added))
      entity.add_event_listener(:component_removed,
                                method(:on_entity_component_removed))

      entity.tags.each do |tag|
        @entities_by_tag[tag] ||= []
        @entities_by_tag[tag] << entity
      end
    end

    def remove_entity(entity)
      entity.tags.each do |tag|
        @entities_by_tag[tag].delete(entity)
      end
      
      entity.remove_event_listener(:component_added,
                                   method(:on_entity_component_added))
      entity.remove_event_listener(:component_removed,
                                   method(:on_entity_component_removed))

      @entities_by_component_mask.each do |component_mask, entities|
        if component_mask.matches?(entity.component_mask)
          entities.delete(entity)
        end
      end
    end

    def get_entities(component_mask)
      @entities_by_component_mask[component_mask] || []
    end

    def get_entities_by_tag(tag)
      @entities_by_tag[tag] || []
    end
    
    private

    def add_entity_to_matching_component_lists(entity)
      @entities_by_component_mask.each do |component_mask, entities|
        component_mask_match = component_mask.matches?(entity.component_mask)

        if component_mask_match && !entities.include?(entity)
          entities << entity
        end
      end
    end

    def on_entity_component_added(entity, component)
      add_entity_to_matching_component_lists(entity)
    end

    def on_entity_component_removed(entity, component)
      old_mask = ComponentMask.from_components(entity.components + component)
      new_mask = entity.component_mask

      @entities_by_component_mask.each do |component_mask, entities|
        old_match = component_mask.match?(old_mask)
        new_match = component_mask.match?(new_mask)
        
        if old_match && !new_match
          entities.delete(entity)
        end
      end      
    end
  end
end
