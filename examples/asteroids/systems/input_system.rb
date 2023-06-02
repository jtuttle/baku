include Components

module Systems
  class InputSystem < Baku::ComponentSystem
    def initialize
      super([PlayerInputComponent,
             RotationComponent,
             VelocityComponent], :update)
    end

    def process_entity(entity, player_input, rotation, velocity)
      if Gosu.button_down?(Gosu::KB_UP)
        angle_radians = rotation.angle * (Math::PI / 180)

        v_x = Math.cos(angle_radians) * player_input.acceleration_speed
        v_y = Math.sin(angle_radians) * player_input.acceleration_speed

        velocity.x = [velocity.x + v_x, player_input.max_velocity].min
        velocity.y = [velocity.y + v_y, player_input.max_velocity].min
      else
        velocity.x *= player_input.friction
        velocity.y *= player_input.friction
      end

      velocity.rotational =
        (Gosu.button_down?(Gosu::KB_LEFT) ? -player_input.rotation_speed : 0) +
        (Gosu.button_down?(Gosu::KB_RIGHT) ? player_input.rotation_speed : 0)
    end
  end
end
