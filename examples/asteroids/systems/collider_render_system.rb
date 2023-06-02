include Components

module Systems
  class ColliderRenderSystem < Baku::ComponentSystem
    def initialize(step = 10, color = 0xff00ff00)
      super([ColliderComponent, TransformComponent], :draw)

      @step = step
      @color = color
    end

    def process_entity(entity, collider, transform)
      radius = collider.radius
      cx = transform.x
      cy = transform.y

      (0..360).step(@step).each do |angle|
        a1 = angle * Math::PI / 180
        p1x = cx + radius * Math.cos(a1)
        p1y = cy + radius * Math.sin(a1)

        a2 = (angle + @step) * Math::PI / 180
        p2x = cx + radius * Math.cos(a2)
        p2y = cy + radius * Math.sin(a2)

        Gosu.draw_line(p1x, p1y, @color, p2x, p2y, @color)
      end
    end
  end
end
