module Baku
  class System
    attr_reader :components, :game_loop_step
    
    def initialize(components, game_loop_step)
      @components = components
      @game_loop_step = game_loop_step
    end

    def register_world(world)
      @world = world
    end

    def execute
      if @world.nil?
        raise StandardError.new("Must set :world property of System.")
      end
      
      entities = retrieve_entities

      process_entities(entities)
    end
    
    def process_entity(entity)
      raise NotImplementedError
    end

    protected

    def retrieve_entities
      raise NotImplementedError
    end
  end
end
