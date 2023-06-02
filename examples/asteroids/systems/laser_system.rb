include Components

module Systems
  class LaserSystem < Baku::ComponentSystem
    def initialize
      super([LaserComponent,
             TransformComponent,
             RotationComponent,
             VelocityComponent], :update)
    end

    def process_entity(entity, laser, transform, rotation, velocity)
      if Gosu.button_down?(Gosu::KB_SPACE) && laser.can_shoot_laser?
        EntityFactory.create_laser(@world, transform, rotation, laser)
        laser.laser_timer = laser.laser_cooldown_ms
      else
        laser.laser_timer = [0, laser.laser_timer - @world.delta_ms].max
      end
    end
  end
end
