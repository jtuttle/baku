module Components
  class PlayerInputComponent
    attr_reader :acceleration_speed, :max_velocity, :rotation_speed, :friction

    def initialize(acceleration_speed:, max_velocity:, rotation_speed:, friction:)
      @acceleration_speed = acceleration_speed
      @max_velocity = max_velocity
      @rotation_speed = rotation_speed
      @friction = friction
    end
  end
end
