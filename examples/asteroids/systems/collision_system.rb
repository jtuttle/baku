include Components

module Systems
  class CollisionSystem < Baku::ComponentSystem
    def initialize
      super([ColliderComponent,
             TransformComponent], :draw)
    end

    def process_entities(entities)
      # Reset collisions each frame.
      entities.each do |entity|
        entity.get_component(ColliderComponent).collisions = []
      end

      for i in (0...entities.length - 1)
        for j in ((i + 1)...entities.length)
          entity_1 = entities[i]
          entity_2 = entities[j]

          if collision?(entity_1, entity_2)
            entity_1.get_component(ColliderComponent).collisions << entity_2
            entity_2.get_component(ColliderComponent).collisions << entity_1
          end
        end
      end
    end

    private

    def collision?(entity_1, entity_2)
      t1 = entity_1.get_component(TransformComponent)
      t2 = entity_2.get_component(TransformComponent)

      r1 = entity_1.get_component(ColliderComponent).radius
      r2 = entity_2.get_component(ColliderComponent).radius

      (t2.x - t1.x) ** 2 + (t2.y - t1.y) ** 2 <= (r1 + r2) ** 2
    end
  end
end
