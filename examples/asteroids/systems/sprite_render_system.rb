include Components

module Systems
  class SpriteRenderSystem < Baku::ComponentSystem
    def initialize
      super([SpriteComponent, TransformComponent, RotationComponent], :draw)
    end

    def process_entities(entities)
      entities.sort! do |e1, e2|
        e1.get_component(TransformComponent).z <=> e2.get_component(TransformComponent).z
      end

      super(entities)
    end

    def process_entity(entity, sprite, transform, rotation)
      sprite.texture.draw_rot(transform.x, transform.y, 0,
                              rotation.angle,
                              sprite.center_x, sprite.center_y,
                              sprite.scale_x, sprite.scale_y)
    end
  end
end
