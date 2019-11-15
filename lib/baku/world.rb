module Baku
  class World
    attr_reader :entity_manager, :blackboard, :delta_ms
    
    def initialize
      # TODO: there's currently no way to interleave update and draw systems.
      # Is this something we'll eventually need?
      @update_systems = []
      @draw_systems = []

      @entity_manager = EntityManager.new
      
      @blackboard = {}
    end

    def dispose
      @update_systems.clear
      @draw_systems.clear
      @entity_manager.dispose
      @blackboard.clear
    end

    def add_system(system)
      system_list = 
        if system.game_loop_step == :update
          @update_systems
        elsif system.game_loop_step == :draw
          @draw_systems
        end

      if system_list.map(&:class).include?(system.class)
        raise StandardError.new("Already added #{system.class} system to world.")
      end

      system.register_world(self)
      
      system_list << system
    end

    def create_entity(tags = [])
      entity = Entity.new(tags)
      @entity_manager.add_entity(entity)
      entity
    end

    def destroy_entity(entity)
      @entity_manager.remove_entity(entity)
    end

    def update(delta_ms)
      @delta_ms = delta_ms
      @update_systems.each(&:execute)
    end

    def draw
      @draw_systems.each(&:execute)
    end
  end
end
