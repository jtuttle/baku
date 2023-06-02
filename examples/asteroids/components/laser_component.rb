module Components
  class LaserComponent
    attr_reader :laser_spawn_distance, :laser_velocity, :laser_lifespan_ms, :laser_cooldown_ms
    attr_accessor :laser_timer
    
    def initialize(laser_spawn_distance:, laser_velocity:, laser_lifespan_ms:, laser_cooldown_ms:)
      @laser_spawn_distance = laser_spawn_distance
      @laser_velocity = laser_velocity
      @laser_lifespan_ms = laser_lifespan_ms
      @laser_cooldown_ms = laser_cooldown_ms 
      
      @laser_timer = 0
    end
    
    def can_shoot_laser?
      @laser_timer == 0
    end
  end
end
