include Components

module Systems
  class MovementSystem < Baku::ComponentSystem
    def initialize
      super([TransformComponent,
             RotationComponent,
             VelocityComponent], :update)
    end

    def process_entity(entity, transform, rotation, velocity)
      transform.x += velocity.x
      transform.y += velocity.y
      rotation.set_angle(rotation.angle + velocity.rotational)
    end
  end
end
