module Components
  class ColliderComponent
    attr_reader :radius
    attr_accessor :collisions
    
    def initialize(radius)
      @radius = radius
      @collisions = []
    end
  end
end
