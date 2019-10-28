module Baku
  class System
    attr_reader :components, :game_loop_step
    attr_writer :world
    
    def initialize(components, game_loop_step)
      @components = components
      @game_loop_step = game_loop_step
    end

    def execute
      if @world.nil?
        raise StandardError.new("Must set :world property of System.")
      end
      
      if enough_time_elapsed?(@world.delta_ms) 
        entities = @world.entity_manager.get_entities(component_mask)

        process_entities(entities)
      end
    end

    def process_entities(entities)
      entities.each do |entity|
        entity_components = @components.map { |c| entity.get_component(c) }
        process_entity(entity, *entity_components)
      end
    end
    
    def process_entity(entity)
      raise NotImplementedError
    end

    def component_mask
      @component_mask ||= ComponentMask.from_components(@components)
    end

    private

    def retrieve_entities
      @world.entity_manager.get_entities(component_mask)
    end

    def enough_time_elapsed?(delta_ms)
      true
    end
  end
end
