module Baku
  class ComponentMask
    attr_reader :value
    
    @@component_set = Set.new

    class << self
      def record_components(components)
        components.each do |component|
          @@component_set << component
        end
      end
      
      def from_components(components)
        record_components(components)

        mask_value = 0

        @@component_set.each_with_index do |component, index|
          mask_value |= (1 << index) if components.include?(component)
        end

        ComponentMask.new(mask_value)
      end
    end
    
    def initialize(value)
      @value = value
    end

    def add_component(component_class)

    end

    def matches?(other_mask)
      @value & other_mask.value == @value
    end

    def ==(other)
      @value == other.value
    end

    def eql?(other)
      self == other
    end

    def hash
      value
    end
  end
end
