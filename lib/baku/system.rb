module Baku
  class System
    attr_reader :components, :game_loop_step
    attr_writer :world
    
    def initialize(components, game_loop_step)
      @components = components
      @game_loop_step = game_loop_step
    end

    def process_entities
      if @world.nil?
        raise StandardError.new("Must set :world property of System.")
      end
      
      @world.entity_manager.get_entities(component_mask).each do |entity|
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
  end
end
