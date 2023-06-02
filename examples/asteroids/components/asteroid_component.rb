module Components
  class AsteroidComponent < Baku::Component
    attr_reader :size

    def initialize(size)
      @size = size
    end
  end
end
