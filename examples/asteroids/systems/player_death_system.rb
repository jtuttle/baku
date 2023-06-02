module Systems
  class PlayerDeathSystem < Baku::ComponentSystem
    def initialize
      super([PlayerStateComponent, ColliderComponent],
            :update)
    end

    def process_entity(entity, player_state, collider)
      collided_asteroid =
        collider.collisions.find do |entity|
          entity.components.has_key?(AsteroidComponent)
        end

      if !collided_asteroid.nil?
        player_state.dead = true
      end
    end
  end
end
