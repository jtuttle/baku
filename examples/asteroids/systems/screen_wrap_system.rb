module Systems
  class ScreenWrapSystem < Baku::ComponentSystem
    def initialize
      super([TransformComponent], :update)

      border = 40

      @left = -border
      @right = GameConfig::SCREEN_WIDTH + border
      @top = -border
      @bottom = GameConfig::SCREEN_HEIGHT + border
    end

    def process_entity(entity, transform)
      if transform.x > @right
        transform.x = @left + (transform.x - @right)
      elsif transform.x < @left
        transform.x = @right - (@left - transform.x)
      end

      if transform.y > @bottom
        transform.y = @top + (transform.y - @bottom)
      elsif transform.y < @top
        transform.y = @bottom - (@top - transform.y)
      end
    end
  end
end
