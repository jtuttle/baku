module Components
  class SpriteComponent
    attr_reader :texture, :center_x, :center_y, :scale_x, :scale_y

    def initialize(texture, center_x: 0.5, center_y: 0.5, scale_x: 1, scale_y: 1)
      @texture = texture
      @center_x = center_x
      @center_y = center_y
      @scale_x = scale_x
      @scale_y = scale_y
    end
  end
end
