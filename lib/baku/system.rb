module Baku
  class System
    attr_reader :components, :game_loop_step
    attr_writer :entity_manager
    
    def initialize(components, game_loop_step)
      @components = components
      @game_loop_step = game_loop_step
    end

    def process_entities
      if @entity_manager.nil?
        raise StandardError.new("Must set :entity_manager property of System.")
      end
      
      @entity_manager.get_entities_with_components(@components).each do |entity|
        entity_components = @components.map { |c| entity.get_component(c) }
        process_entity(entity, *entity_components)
      end
    end
    
    def process_entity(entity)
      raise NotImplementedError
    end
  end
end
