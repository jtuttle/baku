include Components

module Systems
  class AsteroidSplitSystem < Baku::ComponentSystem
    def initialize
      super([AsteroidComponent,
             ColliderComponent,
             TransformComponent], :update)
    end

    def process_entity(entity, asteroid, collider, transform)
      collided_laser =
        collider.collisions.find { |entity| entity.tags.include?(:laser) }

      if !collided_laser.nil?
        @world.destroy_entity(collided_laser)

        @world.destroy_entity(entity)

        if asteroid.size > 1
          EntityFactory.create_asteroid(@world, asteroid.size - 1, transform.x, transform.y)
          EntityFactory.create_asteroid(@world, asteroid.size - 1, transform.x, transform.y)
        end
      end
    end
  end
end
