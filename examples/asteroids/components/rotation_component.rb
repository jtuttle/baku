module Components
  class RotationComponent
    attr_reader :angle

    def initialize(angle)
      @angle = set_angle(angle)
    end

    def set_angle(value)
      @angle = value % 360
    end
  end
end
