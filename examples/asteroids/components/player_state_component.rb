module Components
  class PlayerStateComponent < Baku::Component
    attr_accessor :dead

    def initialize
      @dead = false
    end
  end
end
