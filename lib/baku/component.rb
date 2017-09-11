module Baku
  class Component
    attr_reader :id

    def initialize
      @id = SecureRandom.uuid
    end
  end
end
