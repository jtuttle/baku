module Baku
  # The EntityManager stores entities in such a way that they can be retrieved
  # efficiently by either Component mask or tag. Before storing any entities,
  # the Component masks that we wish to match on should be registered. This step
  # is performed transparently by the World whenever a System is added.
  class EntityManager
    def initialize
      @entities_by_component_mask = {}
      @entities_by_tag = {}

      # TODO: split conversion from components to mask into separate class
      @component_set = Set.new
    end

    def register_component_mask(components)
      components.each do |component|
        @component_set << component
      end

      component_mask = get_component_mask(components)

      @entities_by_component_mask[component_mask] = []
    end

    def add_entity(entity)
      add_entity_to_matching_component_masks(entity)
      
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

      entity_mask = get_component_mask(entity.components)
      
      @entities_by_component_mask.each do |component_mask, entities|
        if component_mask & entity_mask == component_mask
          entities.delete(entity)
        end
      end
    end

    def get_entities_with_components(components)
      @entities_by_component_mask[get_component_mask(components)]
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

    def add_entity_to_matching_component_masks(entity)
      entity_component_mask = get_component_mask(entity.components)

      @entities_by_component_mask.each do |component_mask, entities|
        if component_mask & entity_component_mask == component_mask
          entities << entity
        end
      end
    end

    def on_entity_component_added(entity, component)
      add_entity_to_matching_component_masks(entity)
    end

    def on_entity_component_removed(entity, component)
      old_mask = get_component_mask(entity.components + component)
      new_mask = get_component_mask(entity.components)

      @entities_by_component_mask.each do |component_mask, entities|
        old_match = (component_mask & old_mask == component_mask)
        new_match = (component_mask & new_mask == component_mask)
        
        if old_match && !new_match
          entities.delete(entity)
        end
      end      
    end
  end
end
