module Components
  class TimedDestroyComponent
    attr_accessor :alive_ms
    
    def initialize(lifespan_ms)
      @lifespan_ms = lifespan_ms
      @alive_ms = 0
    end

    def should_be_destroyed?
      @alive_ms > @lifespan_ms
    end
  end
end
