module Components
  class VelocityComponent
    attr_accessor :x, :y, :rotational

    def initialize(x, y, rotational)
      @x = x
      @y = y
      @rotational = rotational
    end
  end
end
