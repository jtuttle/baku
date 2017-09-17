module Baku
  class System
    attr_reader :components, :game_loop_step
    attr_accessor :world
    
    def initialize(components, game_loop_step)
      @components = components
      @game_loop_step = game_loop_step
    end

    def execute
      entities = @world.entity_manager.get_entities_by_system(self)

      entities.each do |entity|
        entity_components = @components.map { |c| entity.get_component(c) }
        process_entity(entity, *entity_components)
      end
    end

    def process_entity(entity)
      raise NotImplementedError
    end
  end
end
