module Baku
  class System
    attr_reader :components, :game_loop_step
    
    def initialize(components, game_loop_step)
      @components = components
      @game_loop_step = game_loop_step
    end

    # TODO: There's nothing preventing a system from processing entities that
    # don't match its component signature. Is it worth adding some kind of 
    # validation or some other way of ensuring that the components match?
    def process_entities(entities)
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
