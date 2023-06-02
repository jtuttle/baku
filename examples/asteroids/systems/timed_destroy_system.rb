module Systems
  class TimedDestroySystem < Baku::ComponentSystem
    def initialize
      super([TimedDestroyComponent], :update)
    end

    def process_entity(entity, destroy_timer)
      if destroy_timer.should_be_destroyed?
        @world.destroy_entity(entity)
      else
        destroy_timer.alive_ms += @world.delta_ms
      end
    end
  end
end
