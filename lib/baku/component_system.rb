require_relative 'system'

module Baku
  class ComponentSystem < System
    attr_reader :components
    
    def initialize(components, game_loop_step)
      @components = components
      @game_loop_step = game_loop_step
    end

    def register_world(world)
      super(world)

      world.entity_manager.register_component_mask(component_mask)
    end

    def process_entities(entities)
      entities.each do |entity|
        entity_components = @components.map { |c| entity.get_component(c) }
        process_entity(entity, *entity_components)
      end
    end

    def component_mask
      @component_mask ||= ComponentMask.from_components(@components)
    end
    
    protected

    def retrieve_entities
      @world.entity_manager.get_entities(component_mask)
    end
  end
end
